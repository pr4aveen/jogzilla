import 'package:flutter/foundation.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class RouteDrawer {
  static Future<void> drawRoute(
      {@required List<LatLng> route,
      @required MapboxMapController controller,
      bool modifyCenter = true,
      double opacity}) async {
    await controller.clearLines();
    await controller.clearCircles();

    if (modifyCenter) {
      double _centerLatitude = 0;
      double _centerLongitude = 0;

      for (int i = 0; i < route.length; i++) {
        _centerLatitude += route[i].latitude;
        _centerLongitude += route[i].longitude;
      }

      _centerLatitude /= route.length;
      _centerLongitude /= route.length;

      LatLng newCenter = LatLng(_centerLatitude, _centerLongitude);
      CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(newCenter, 14);
      await controller.moveCamera(cameraUpdate);
    }
    await controller.addLine(
      LineOptions(
        geometry: route,
        lineWidth: 7,
        lineOpacity: opacity == null ? 1.0 : opacity,
        lineColor: '#000000',
      ),
    );

    await controller.addCircle(CircleOptions(
      circleRadius: 5,
      geometry: route.elementAt(0),
      circleColor: '#ff0000',
    ));
  }
}
