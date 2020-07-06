import 'dart:math';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:geolocator/geolocator.dart';

import './mapbox_api_request.dart';

class RouteGenerator {
  LatLng start;
  double generateDistance = 3;
  double actualDistance = 0;

  RouteGenerator({this.start, this.generateDistance});

  LatLng _generatePoint(LatLng start, double bearing, double d) {
    const p = pi / 180;
    var lat1 = start.latitude * p;
    var lon1 = start.longitude * p;
    var R = 6371;

    var lat2 =
        asin(sin(lat1) * cos(d / R) + cos(lat1) * sin(d / R) * cos(bearing));
    var lon2 = lon1 +
        atan2(sin(bearing) * sin(d / R) * cos(lat1),
            cos(d / R) - sin(lat1) * sin(lat2));
    return LatLng(lat2 / p, lon2 / p);
  }

  List<LatLng> _generateWaypoints(LatLng start, double distance) {
    LatLng point1;
    LatLng point2;
    LatLng point3;
    Random rng = Random();

    double bearing = rng.nextDouble() * 2 * pi;

    point1 = _generatePoint(start, bearing, distance / 7);
    bearing = (bearing + pi / 4) % (2 * pi);

    point2 = _generatePoint(start, bearing, distance / 7 * sqrt(2));
    bearing = (bearing + pi / 4) % (2 * pi);
    point3 = _generatePoint(start, bearing, distance / 7);

    return [start, point1, point2, point3, start];
  }

  Future<double> _routeDistance(List<LatLng> route) async {
    double totalDistance = 0;
    Geolocator geolocator = Geolocator();

    for (var i = 0; i < route.length - 1; i++) {
      totalDistance += await geolocator.distanceBetween(
          route.elementAt(i).latitude,
          route.elementAt(i).longitude,
          route.elementAt(i + 1).latitude,
          route.elementAt(i + 1).longitude);
    }
    return totalDistance / 1000;
  }

  Future<List<LatLng>> _generate() {
    List<LatLng> waypoints = _generateWaypoints(start, generateDistance);

    List<Future<List<LatLng>>> linesFuture = [];
    for (int i = 0; i < waypoints.length - 1; i++) {
      linesFuture
          .add(MapboxApiRequest.createLine(waypoints[i], waypoints[i + 1]));
    }

    Future<List<List<LatLng>>> lines = Future.wait(linesFuture);
    Future<List<LatLng>> linesJoined = lines.then((lines) {
      return lines.reduce((value, element) {
        value.addAll(element);
        return value;
      });
    });

    return linesJoined;
  }

  Future<List<LatLng>> generateRoute(double threshold) async {
    Future<List<LatLng>> tempRoute = _generate();
    double tempDist = await tempRoute.then((route) => _routeDistance(route));
    print(tempDist);
    if (tempDist < generateDistance * (1 - threshold) ||
        tempDist > generateDistance * (1 + threshold)) {
      return generateRoute(threshold * 1.01);
    } else {
      actualDistance = tempDist;
      return tempRoute;
    }
  }
}
