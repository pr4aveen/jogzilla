import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/placeholder_widget.dart';
import '../widgets/run_progress_card.dart';

class RunProgressPage extends StatefulWidget {
  static const String routeName = 'run_progress_page';

  @override
  _RunProgressPageState createState() => _RunProgressPageState();
}

class _RunProgressPageState extends State<RunProgressPage> {
  StreamSubscription<Position> _positionStreamSubscription;
  final List<Position> _positions = [];
  double _totalDistance = 0.0;
  Position _prev;

  double _avgSpeed = 0.0;

  Stopwatch _stopwatch = Stopwatch();
  String _timeToDisplay = "00h 00m 00s";
  final duration = const Duration(seconds: 1);

  void keepRunning() {
    if (_stopwatch.isRunning) {
      startTimer();
    }
    setState(() {
      _timeToDisplay = _stopwatch.elapsed.inHours.toString().padLeft(2, '0') +
          'h ' +
          (_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, '0') +
          'm ' +
          (_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0') +
          's ';
      _avgSpeed = _totalDistance * 1000 / _stopwatch.elapsed.inSeconds;
    });
  }

  void startTimer() {
    Timer(duration, keepRunning);
  }

  void startStopwatch() {
    _stopwatch.start();
    startTimer();
  }

  void pauseStopwatch() {
    _stopwatch.stop();
  }

  void stopStopwatch() {}

  Future<void> _getDistance(Position prev, Position cur) async {
    Geolocator()
        .distanceBetween(
            prev.latitude, prev.longitude, cur.latitude, cur.longitude)
        .then(
      (value) {
        setState(() {
          _totalDistance += value / 1000;
        });
      },
    );
  }

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      const LocationOptions locationOptions =
          LocationOptions(accuracy: LocationAccuracy.best);
      final Stream<Position> positionStream =
          Geolocator().getPositionStream(locationOptions);
      _positionStreamSubscription = positionStream.listen(
        (Position position) async {
          _positions.add(position);
          await _getDistance(_prev ?? position, position)
              .then((_) => _prev = position);
        },
      );
      _positionStreamSubscription.pause();
    }

    setState(() {
      if (_positionStreamSubscription.isPaused) {
        _positionStreamSubscription.resume();
        startStopwatch();
      } else {
        _positionStreamSubscription.pause();
        pauseStopwatch();
      }
    });
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription.cancel();
      _positionStreamSubscription = null;
    }
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
                      child: _isListening()
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
                                      onTap: _toggleListening),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    child: RunProgressCard(
                                      cardText: 'STOP',
                                      backgroundColor: Colors.red,
                                      textColor: Colors.black,
                                    ),
                                    onLongPress: _toggleListening,
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
                              onTap: _toggleListening)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool _isListening() => !(_positionStreamSubscription == null ||
      _positionStreamSubscription.isPaused);
}
