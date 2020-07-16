import 'package:mapbox_gl/mapbox_gl.dart';

class RunDataList {
  List<RunData> runs;

  RunDataList() {
    runs = new List();
  }

  toJSONEncodable() {
    return runs.map((runData) => runData.toJSONEncodable()).toList();
  }
}

class RunData {
  final String distance;
  final String duration;
  final String dateTime;
  final String pace;
  final String description;
  final List<LatLng> positions;

  RunData(
      {this.dateTime,
      this.duration,
      this.distance,
      this.pace,
      this.positions,
      this.description});

  toJSONEncodable() {
    Map<String, dynamic> map = Map();

    map['distance'] = distance;
    map['duration'] = duration;
    map['dateTime'] = dateTime;
    map['pace'] = pace;
    map['description'] = description;
    map['positions'] = positions;

    return map;
  }
}
