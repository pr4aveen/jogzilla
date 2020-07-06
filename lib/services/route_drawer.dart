import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class RouteDrawer {
  MapboxMapController mapboxMapController;

  RouteDrawer({this.mapboxMapController});

  void drawRoute(List<LatLng> route) {
    mapboxMapController.addLine(
      LineOptions(
        geometry: route,
        lineWidth: 7,
        lineOpacity: 0.5,
        lineColor: '#0000ff',
      ),
    );

    mapboxMapController.addCircle(CircleOptions(
      circleRadius: 5,
      geometry: route.elementAt(0),
      circleColor: '#ff0000',
    ));
  }
}
