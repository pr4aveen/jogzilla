import 'dart:convert';

import 'package:mapbox_gl/mapbox_gl.dart';

class RunData {
  final int runId;
  final DateTime dateTime;
  final double distance;
  final int duration;
  final double pace;
  final double calories;
  final List<LatLng> positions;
  String title;
  String description;

  RunData({
    this.runId,
    this.dateTime,
    this.distance,
    this.duration,
    this.pace,
    this.calories,
    this.positions,
    this.title,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'runId': runId,
      'dateTime': dateTime.toString(),
      'distance': distance,
      'duration': duration,
      'pace': pace,
      'calories': calories,
      'positions': jsonEncode(positions),
      'title': title,
      'description': description,
    };
  }

  factory RunData.fromMap(Map<String, dynamic> json) {
    print(json['positions']);
    return new RunData(
      runId: json['runID'],
      dateTime: DateTime.parse(json['dateTime']),
      distance: json['distance'],
      duration: json['duration'],
      pace: json['pace'],
      calories: json['calories'],
      positions: List<LatLng>.from(
          jsonDecode(json['positions']).map((pos) => LatLng(pos[0], pos[1]))),
      title: json['title'],
      description: json['description'],
    );
  }
}
