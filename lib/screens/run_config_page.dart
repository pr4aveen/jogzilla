import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../services/route_drawer.dart';
import '../services/route_generator.dart';

class RunConfigPage extends StatelessWidget {
  MapboxMapController myController;
  LatLng start = LatLng(1.437783, 103.836867);

  final double generateDistance = 3.0;

  void _onMapCreated(MapboxMapController controller) {
    myController = controller;
  }

  void _addRoute() async {
    myController.clearLines();
    myController.clearCircles();

    RouteGenerator routeGenerator =
        RouteGenerator(start: start, generateDistance: generateDistance);

    List<LatLng> route = await routeGenerator.generateRoute(0.1);

    RouteDrawer(mapboxMapController: myController).drawRoute(route);

    // setState(() {
    //   actualDistance = routeGenerator.actualDistance;
    // });
  }

  static const String routeName = 'run_config_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Generate Run Route',
        ),
      ),
      body: Column(
        children: [
          Align(
            child: Container(
              child: MapboxMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition:
                      CameraPosition(target: start, zoom: 13)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.70,
            ),
            alignment: Alignment.center,
          ),
          Text('Distance:'),
          Text(0.toString()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFFEB3153),
        label: Text('Generate'),
        onPressed: _addRoute,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
