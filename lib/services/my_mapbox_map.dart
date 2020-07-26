import 'package:jogzilla/services/route_drawer.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MyMapboxMap {
  MyMapboxMap._privateConstructor();
  static final MyMapboxMap instance = MyMapboxMap._privateConstructor();

  static MapboxMapController myController;
  static MapboxMap _map;

  MapboxMap get map {
    if (_map != null) {
      return _map;
    } else {
      return MapboxMap(
        myLocationEnabled: true,
        myLocationTrackingMode: MyLocationTrackingMode.Tracking,
        styleString: MapboxStyles.LIGHT,
        onMapCreated: (controller) => myController = controller,
        initialCameraPosition: CameraPosition(target: LatLng(0, 0), zoom: 14),
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
      );
    }
  }

  void draw(List<LatLng> route) {
    RouteDrawer.drawRoute(route: route, controller: myController);
  }
}
