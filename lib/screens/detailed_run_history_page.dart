import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../models/run_data.dart';
import '../services/route_drawer.dart';
import '../widgets/run_summary_header.dart';

class DetailedRunHistoryPage extends StatelessWidget {
  static const String routeName = 'detailed_run_history_page';
  final RunData runData;

  DetailedRunHistoryPage({@required this.runData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(runData.title),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              child: MapboxMap(
                onMapCreated: (controller) {
                  RouteDrawer.drawRoute(
                      route: runData.positions, controller: controller);
                },
                initialCameraPosition:
                    CameraPosition(target: LatLng(0, 0), zoom: 14),
                styleString: MapboxStyles.LIGHT,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
            ),
            RunSummaryHeader(
              runData: runData,
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
