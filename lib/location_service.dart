import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationService {
  LocationService({this.locationServiceCallback});

  Function locationServiceCallback;
  StreamSubscription<Position> _positionStreamSubscription;
  Position _prev;

  Future<void> _getDistance(Position prev, Position cur) async {
    Geolocator()
        .distanceBetween(
            prev.latitude, prev.longitude, cur.latitude, cur.longitude)
        .then(
      (value) {
        locationServiceCallback(distance: value, position: cur);
      },
    );
  }

  void toggleListening() {
    if (_positionStreamSubscription == null) {
      const LocationOptions locationOptions =
          LocationOptions(accuracy: LocationAccuracy.best);
      final Stream<Position> positionStream =
          Geolocator().getPositionStream(locationOptions);
      _positionStreamSubscription = positionStream.listen(
        (Position position) async {
          await _getDistance(_prev ?? position, position)
              .then((_) => _prev = position);
        },
      );
      _positionStreamSubscription.pause();
    }

    if (_positionStreamSubscription.isPaused) {
      _positionStreamSubscription.resume();
    } else {
      _positionStreamSubscription.pause();
    }
  }

  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription.cancel();
      _positionStreamSubscription = null;
    }
  }

  bool isListening() => !(_positionStreamSubscription == null ||
      _positionStreamSubscription.isPaused);
}
