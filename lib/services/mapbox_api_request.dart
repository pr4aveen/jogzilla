import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';

import '../api_key.dart';

class RouteResponse {
  List<Route> routes;

  RouteResponse({this.routes});

  factory RouteResponse.fromJson(Map<String, dynamic> json) {
    var list = json['routes'] as List;
    List<Route> routeList = list.map((i) => Route.fromJson(i)).toList();

    return RouteResponse(routes: routeList);
  }
}

class Route {
  Geometry geometry;

  Route({this.geometry});

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(geometry: Geometry.fromJson(json['geometry']));
  }
}

class Geometry {
  List<List<dynamic>> coords;

  Geometry({this.coords});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    var list = json['coordinates'];
    List<List<dynamic>> coordsList = new List<List<dynamic>>.from(list);

    return Geometry(coords: coordsList);
  }
}

class MapboxApiRequest {
  static String accessToken = API_KEY;

  static Future<http.Response> _queryResponse(LatLng start, LatLng end) {
    return http.get('https://api.mapbox.com/directions/v5/mapbox/walking/' +
        start.longitude.toString() +
        ',' +
        start.latitude.toString() +
        ';' +
        end.longitude.toString() +
        ',' +
        end.latitude.toString() +
        '?' +
        'geometries=geojson&access_token=' +
        accessToken);
  }

  static Future<RouteResponse> _fetchResponse(LatLng start, LatLng end) async {
    final http.Response response = await _queryResponse(start, end);
    if (response.statusCode == 200) {
      return RouteResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  static Future<List<LatLng>> createLine(LatLng start, LatLng end) {
    Future<RouteResponse> response = _fetchResponse(start, end);
    return response.then((r) => r.routes
        .elementAt(0)
        .geometry
        .coords
        .map((coord) => LatLng(coord.elementAt(1), coord.elementAt(0)))
        .toList());
  }
}
