import 'package:flutter/foundation.dart';

class RunData {
  final String distance;
  final String duration;
  final String dateTime;
  final String pace;
  final String description;

  RunData(
      {@required this.dateTime,
      @required this.duration,
      @required this.distance,
      @required this.pace,
      this.description});
}
