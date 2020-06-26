import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jogzilla/location_service.dart';

import '../widgets/placeholder_widget.dart';
import '../widgets/run_progress_card.dart';
import '../stopwatch_service.dart';
import '../location_service.dart';

class RunProgressPage extends StatefulWidget {
  static const String routeName = 'run_progress_page';

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

  void _stopwatchCallback(
      {String hours, String minutes, String seconds, int totalSeconds}) {
    setState(() {
      _timeToDisplay = '${hours}h ${minutes}m ${seconds}s';
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
            return const PlaceholderWidget('Location services disabled',
                'Enable location services for this App using the device settings.');
          }

          return SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: RunProgressCard(
                      cardText: '${_totalDistance.toStringAsFixed(2)} km',
                      textSize: 48,
                      backgroundColor: Theme.of(context).accentColor,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: RunProgressCard(
                            cardText: _timeToDisplay,
                            textSize: 28,
                            backgroundColor: Theme.of(context).accentColor,
                          ),
                        ),
                        Expanded(
                          child: RunProgressCard(
                            cardText: '${_avgSpeed.toStringAsFixed(2)} km/h',
                            textSize: 28,
                            backgroundColor: Theme.of(context).accentColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: _listening
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  child: RunProgressCard(
                                    cardText: 'PAUSE',
                                    backgroundColor: Colors.yellow,
                                    textColor: Colors.black,
                                  ),
                                  onTap: _toggle,
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  child: RunProgressCard(
                                    cardText: 'STOP',
                                    backgroundColor: Colors.red,
                                    textColor: Colors.black,
                                  ),
                                  onLongPress: null,
                                ),
                              )
                            ],
                          )
                        : GestureDetector(
                            child: RunProgressCard(
                              cardText: 'START',
                              backgroundColor: Colors.green,
                              textColor: Colors.black,
                            ),
                            onTap: _toggle,
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
