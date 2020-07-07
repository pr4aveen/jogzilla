import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class RunData {
  final String distance;
  final String duration;
  final String dateTime;
  final String pace;
  final String description;
  final List<Position> positions;

  RunData(
      {this.dateTime,
      this.duration,
      this.distance,
      this.pace,
      this.positions,
      this.description});
}
