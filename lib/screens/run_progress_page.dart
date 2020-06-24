import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RunProgressPage extends StatefulWidget {
  static const String routeName = 'run_progress_page';

  @override
  _RunProgressPageState createState() => _RunProgressPageState();
}

class _RunProgressPageState extends State<RunProgressPage> {
  StreamSubscription<Position> _positionStreamSubscription;
  final List<Position> _positions = <Position>[];
  double _totalDistance = 0.0;
  Position _prev;

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
      } else {
        _positionStreamSubscription.pause();
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(child: RunProgressCard(cardText: '12m 34s')),
                        Expanded(child: RunProgressCard(cardText: '15 km/h'))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          child: Expanded(
                              child: RunProgressCard(cardText: 'PAUSE')),
                          onTap: _toggleListening,
                        ),
                        GestureDetector(
                          child: Expanded(
                              child: RunProgressCard(cardText: 'STOP')),
                          onLongPress: _toggleListening,
                        )
                      ],
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

  // bool _isListening() => !(_positionStreamSubscription == null ||
  //     _positionStreamSubscription.isPaused);
}

class RunProgressCard extends StatelessWidget {
  final String cardText;
  final double textSize;

  RunProgressCard({@required this.cardText, this.textSize = 32.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          cardText,
          style: TextStyle(
            fontSize: textSize,
          ),
        ),
      ),
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget(this.title, this.message);

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(title,
              style: const TextStyle(fontSize: 32.0),
              textAlign: TextAlign.center),
          Text(message,
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
