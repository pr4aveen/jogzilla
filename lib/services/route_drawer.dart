import 'package:flutter/foundation.dart';

import 'package:mapbox_gl/mapbox_gl.dart';

class RouteDrawer {
  static void drawRoute(
      {@required List<LatLng> route,
      @required MapboxMapController controller}) {
    controller.clearLines();
    controller.clearCircles();

    controller.addLine(
      LineOptions(
        geometry: route,
        lineWidth: 7,
        lineOpacity: 0.5,
        lineColor: '#0000ff',
      ),
    );

    controller.addCircle(CircleOptions(
      circleRadius: 5,
      geometry: route.elementAt(0),
      circleColor: '#ff0000',
    ));
  }
}
