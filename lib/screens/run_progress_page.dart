import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:wakelock/wakelock.dart';

import '../models/run_data.dart';
import '../screens/save_run_page.dart';
import '../services/calories_calculator.dart';
import '../services/database_storage.dart';
import '../services/location_service.dart';
import '../services/route_drawer.dart';
import '../services/stopwatch_service.dart';
import '../widgets/placeholder_widget.dart';
import '../widgets/run_data_item.dart';

class RunProgressPage extends StatefulWidget {
  static const String routeName = 'run_progress_page';
  final List<LatLng> route;

  RunProgressPage({this.route = const []});

  @override
  _RunProgressPageState createState() => _RunProgressPageState();
}

class _RunProgressPageState extends State<RunProgressPage> {
  final List<Position> _positions = [];
  double _totalDistance = 0.0;
  bool _listening = false;
  int _totalSeconds = 0;
  String _timeToDisplay = "00:00";
  double _avgSpeed = 0.0;
  bool _stopped = false;

  StopwatchService stopwatchService;
  LocationService locationService;

  MapboxMapController mapController;

  final DatabaseStorage storage = DatabaseStorage.instance;

  void _stopwatchCallback(
      {String hours, String minutes, String seconds, int totalSeconds}) {
    if (this.mounted) {
      String timeString = '$minutes:$seconds';
      if (hours != "00") {
        timeString = '$hours:$timeString';
      }
      setState(() {
        _timeToDisplay = timeString;
        _avgSpeed = _totalDistance * 1000 / totalSeconds;
      });
      _totalSeconds = totalSeconds;
    }
  }

  void _locationServiceCallback(
      {double distance, Position position, bool listening}) {
    if (this.mounted) {
      if (distance != null && position != null) {
        setState(() {
          _totalDistance += distance / 1000;
        });
        if (_positions.length > 1) {
          mapController.addLine(
            LineOptions(
              geometry: [
                LatLng(_positions.last.latitude, _positions.last.longitude),
                LatLng(position.latitude, position.longitude),
              ],
              lineWidth: 7,
              lineOpacity: 1.0,
              lineColor: '#000000',
            ),
          );
        }
        _positions.add(position);
      } else {
        setState(() {
          _listening = listening;
        });
      }
    }
  }

  void _toggle() {
    locationService.toggleListening();
    stopwatchService.toggleStopwatch();
  }

  Future<RunData> get _completeRun async {
    locationService.stop();
    stopwatchService.stop();
    setState(() {
      _stopped = true;
    });
    int runId = await storage.queryRowCount() + 1;
    List<LatLng> positions = List<LatLng>.from(
        _positions.map((pos) => LatLng(pos.latitude, pos.longitude)));

    Function twoDP = (double db) => double.parse(db.toStringAsFixed(2));

    RunData runData = RunData(
      runId: runId,
      dateTime: DateTime.now(),
      duration: _totalSeconds,
      distance: twoDP(_totalDistance),
      pace: twoDP(_avgSpeed),
      calories: twoDP(CaloriesCalculator().calculate(_totalDistance)),
      positions: positions,
    );
    return runData;
  }

  @override
  void initState() {
    super.initState();
    stopwatchService =
        StopwatchService(timeToDisplayCallback: _stopwatchCallback);
    locationService =
        LocationService(locationServiceCallback: _locationServiceCallback);
    Wakelock.enable();
  }

  @override
  void dispose() {
    locationService.dispose();
    stopwatchService.dispose();
    mapController.dispose();
    locationService = null;
    stopwatchService = null;
    mapController = null;
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Current Run'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<GeolocationStatus>(
        future: Geolocator().checkGeolocationPermissionStatus(
            locationPermission: GeolocationPermission.locationWhenInUse),
        builder:
            (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == GeolocationStatus.denied) {
            return const PlaceholderWidget(
                title: 'Location services disabled',
                message:
                    'Enable location services for this App using the device settings.');
          }

          return SafeArea(
            child: _stopped
                ? const Center(child: CircularProgressIndicator())
                : Stack(
                    children: <Widget>[
                      Container(
                        child: MapboxMap(
                          myLocationEnabled: true,
                          myLocationTrackingMode:
                              MyLocationTrackingMode.Tracking,
                          styleString: MapboxStyles.LIGHT,
                          onMapCreated: (controller) {
                            mapController = controller;
                          },
                          onStyleLoadedCallback: () {
                            if (widget.route.isNotEmpty) {
                              RouteDrawer.drawRoute(
                                  route: widget.route,
                                  controller: mapController,
                                  opacity: 0.5,
                                  modifyCenter: false);
                            }
                          },
                          initialCameraPosition:
                              CameraPosition(target: LatLng(0, 0), zoom: 17),
                          rotateGesturesEnabled: false,
                          tiltGesturesEnabled: false,
                          zoomGesturesEnabled: false,
                          scrollGesturesEnabled: false,
                          myLocationRenderMode: MyLocationRenderMode.NORMAL,
                        ),
                        width: screenWidth,
                        height: screenHeight,
                      ),
                      Container(
                        height: screenHeight * 0.20,
                        width: screenWidth * 0.90,
                        margin: EdgeInsets.only(bottom: screenHeight * 0.04),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: new BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  RunDataItem(
                                      label: 'distance',
                                      value:
                                          '${_totalDistance.toStringAsFixed(2)} km',
                                      color: Colors.white),
                                  RunDataItem(
                                    label: 'time',
                                    value: _timeToDisplay,
                                    color: Colors.white,
                                  ),
                                  RunDataItem(
                                    label: 'avg speed',
                                    value:
                                        '${_avgSpeed.toStringAsFixed(2)} km/h',
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: _listening
                                              ? Colors.yellow
                                              : Colors.green,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            _listening ? 'pause' : 'start',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 32,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: _toggle,
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'stop',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 32,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: () async {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                          SaveRunPage.routeName,
                                          (_) => false,
                                          arguments: await _completeRun,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                    alignment: Alignment.bottomCenter,
                  ),
          );
        },
      ),
    );
  }
}
