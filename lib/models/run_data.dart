import 'dart:convert';

import 'package:mapbox_gl/mapbox_gl.dart';

class RunData {
  final int runId;
  final String dateTime;
  final String distance;
  final String duration;
  final String pace;
  final String calories;
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
      'dateTime': dateTime,
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
      dateTime: json['dateTime'].toString(),
      distance: json['distance'].toString(),
      duration: json['duration'].toString(),
      pace: json['pace'].toString(),
      calories: json['calories'].toString(),
      positions: List<LatLng>.from(
          jsonDecode(json['positions']).map((pos) => LatLng(pos[0], pos[1]))),
      title: json['title'],
      description: json['description'],
    );
  }
}
