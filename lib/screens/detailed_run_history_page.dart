import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../models/run_data.dart';
import '../services/route_drawer.dart';
import '../widgets/run_summary_header.dart';

class DetailedRunHistoryPage extends StatefulWidget {
  static const String routeName = 'detailed_run_history_page';
  final RunData runData;
  DetailedRunHistoryPage({@required this.runData});

  @override
  _DetailedRunHistoryPageState createState() => _DetailedRunHistoryPageState();
}

class _DetailedRunHistoryPageState extends State<DetailedRunHistoryPage> {
  MapboxMapController mapController;

  @override
  void dispose() {
    mapController.dispose();
    mapController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.runData.title),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              child: MapboxMap(
                onMapCreated: (controller) => mapController = controller,
                initialCameraPosition:
                    CameraPosition(target: LatLng(0, 0), zoom: 14),
                onStyleLoadedCallback: () {
                  RouteDrawer.drawRoute(
                      route: widget.runData.positions,
                      controller: mapController);
                  print('drawn');
                },
                styleString: MapboxStyles.LIGHT,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
            ),
            RunSummaryHeader(
              runData: widget.runData,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
