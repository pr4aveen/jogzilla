import 'package:jogzilla/services/route_drawer.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MyMapboxMap {
  static MapboxMapController myController;
  static MapboxMap _map;
  static Function customCallBack;
  static Line currentLine;

  static MapboxMap get map {
    if (_map != null) {
      return _map;
    } else {
      _map = MapboxMap(
        myLocationEnabled: true,
        myLocationTrackingMode: MyLocationTrackingMode.Tracking,
        styleString: MapboxStyles.LIGHT,
        onMapCreated: (controller) {
          myController = controller;
          print('map created');
        },
        onStyleLoadedCallback: () {
          if (customCallBack != null) {
            customCallBack();
            customCallBack = null;
          }
        },
        initialCameraPosition: CameraPosition(target: LatLng(0, 0), zoom: 14),
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
      );
      return _map;
    }
  }

  static void draw(List<LatLng> route) {
    if (myController == null) {
      customCallBack =
          () => RouteDrawer.drawRoute(route: route, controller: myController);
      map;
    } else {
      RouteDrawer.drawRoute(route: route, controller: myController);
    }
    print(myController.toString() + ' controller');
  }
}
