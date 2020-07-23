import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:geolocator/geolocator.dart';

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
  double _generateDistance = 3.0;
  Future<LatLng> _start;
  bool _generated = false;
  double _actualDistance = 0.0;
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    _start = _setCurrentLocation();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  Future<LatLng> _setCurrentLocation() async {
    Position pos = await Geolocator().getCurrentPosition();
    return LatLng(pos.latitude, pos.longitude);
  }

  void _addRoute() async {
    setState(() {
      _isGenerating = true;
    });
    RouteGenerator routeGenerator = RouteGenerator(
        start: await _start, generateDistance: _generateDistance);

    List<LatLng> route = await routeGenerator.generateRoute(0.1);
    _generated = true;
    RouteDrawer.drawRoute(controller: mapController, route: route);
    setState(() {
      _actualDistance = routeGenerator.actualDistance;
      _isGenerating = false;
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
      body: FutureBuilder(
        future: _start,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                Stack(
                  children: <Widget>[
                    Container(
                      child: MapboxMap(
                        myLocationEnabled: true,
                        myLocationTrackingMode: MyLocationTrackingMode.Tracking,
                        styleString: MapboxStyles.LIGHT,
                        onMapCreated: (controller) =>
                            mapController = controller,
                        initialCameraPosition:
                            CameraPosition(target: snapshot.data, zoom: 14),
                        rotateGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        zoomGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        myLocationRenderMode: MyLocationRenderMode.NORMAL,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Route distance: ${_actualDistance.toStringAsFixed(1)} km',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _isGenerating
                        ? Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.60,
                          )
                        : Container(),
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
                      message: '${_generateDistance.toStringAsFixed(1)} km',
                      reversed: true,
                    ),
                    PlaceholderWidget(
                      title: 'Actual Distance',
                      message: '${_actualDistance.toStringAsFixed(1)} km',
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
                    value: _generateDistance.toDouble(),
                    onChanged: (double dist) {
                      setState(() {
                        _generateDistance = dist;
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
                      onPressed: _generated
                          ? () => Navigator.pushNamedAndRemoveUntil(
                              context, RunProgressPage.routeName, (_) => false)
                          : null,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }
}
