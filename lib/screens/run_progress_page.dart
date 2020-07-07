import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../services/location_service.dart';
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

  String _timeToDisplay = "00h 00m 00s";
  double _avgSpeed = 0.0;

  StopwatchService stopwatchService;
  LocationService locationService;

  MapboxMapController mapController;

  void _stopwatchCallback(
      {String hours, String minutes, String seconds, int totalSeconds}) {
    String timeString = seconds + 's';
    if (minutes != "00") {
      timeString = '${minutes}m $timeString';
    }
    if (hours != "00") {
      timeString = '${hours}m $timeString';
    }
    setState(() {
      _timeToDisplay = timeString;
      _avgSpeed = _totalDistance * 1000 / totalSeconds;
    });
  }

  void _locationServiceCallback(
      {double distance, Position position, bool listening}) {
    if (distance != null && position != null) {
      setState(() {
        _totalDistance += distance / 1000;
      });
      _positions.add(position);
    } else {
      setState(() {
        _listening = listening;
      });
    }
  }

  void _toggle() {
    locationService.toggleListening();
    stopwatchService.toggleStopwatch();
  }

  @override
  void initState() {
    super.initState();
    stopwatchService =
        StopwatchService(timeToDisplayCallback: _stopwatchCallback);
    locationService =
        LocationService(locationServiceCallback: _locationServiceCallback);
  }

  @override
  void dispose() {
    locationService.dispose();
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
            child: Stack(
              children: <Widget>[
                Container(
                  child: MapboxMap(
                    onMapCreated: (controller) => mapController = controller,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(1.2839, 103.8607), zoom: 14),
                    rotateGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    zoomGesturesEnabled: false,
                    scrollGesturesEnabled: false,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              value: '${_avgSpeed.toStringAsFixed(2)} km/h',
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                onTap: () => print('stop'),
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
