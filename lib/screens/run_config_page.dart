import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import './run_progress_page.dart';
import '../services/route_drawer.dart';
import '../services/route_generator.dart';
import '../widgets/placeholder_widget.dart';

class RunConfigPage extends StatefulWidget {
  static const String routeName = 'run_config_page';

  @override
  _RunConfigPageState createState() => _RunConfigPageState();
}

class _RunConfigPageState extends State<RunConfigPage> {
  MapboxMapController mapController;
  double generateDistance = 3.0;
  LatLng start = LatLng(1.2839, 103.8607);
  bool generated = false;
  double actualDistance = 0.0;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  void _addRoute() async {
    RouteGenerator routeGenerator =
        RouteGenerator(start: start, generateDistance: generateDistance);

    List<LatLng> route = await routeGenerator.generateRoute(0.1);
    generated = true;
    RouteDrawer.drawRoute(controller: mapController, route: route);
    setState(() {
      actualDistance = routeGenerator.actualDistance;
    });
  }

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
          Stack(
            children: <Widget>[
              Container(
                child: MapboxMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition:
                      CameraPosition(target: start, zoom: 14),
                  rotateGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.60,
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5.0, right: 5.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Route distance: ${actualDistance.toStringAsFixed(1)} km',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              PlaceholderWidget(
                title: 'Target Distance',
                message: '${generateDistance.toStringAsFixed(1)} km',
                reversed: true,
              ),
              PlaceholderWidget(
                title: 'Actual Distance',
                message: '${actualDistance.toStringAsFixed(1)} km',
                reversed: true,
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: 15.0,
              ),
              overlayShape: RoundSliderOverlayShape(
                overlayRadius: 30.0,
              ),
              activeTrackColor: Colors.white,
              thumbColor: Theme.of(context).primaryColor,
              overlayColor: Color(0x29EB1555),
              inactiveTrackColor: Theme.of(context).accentColor,
            ),
            child: Slider(
              min: 3,
              max: 30,
              value: generateDistance.toDouble(),
              onChanged: (double dist) {
                setState(() {
                  generateDistance = dist;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                child: Text('Generate'),
                onPressed: _addRoute,
                color: Theme.of(context).primaryColor,
              ),
              RaisedButton(
                child: Text('Run'),
                onPressed: generated
                    ? () =>
                        Navigator.pushNamed(context, RunProgressPage.routeName)
                    : null,
                color: Theme.of(context).primaryColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
