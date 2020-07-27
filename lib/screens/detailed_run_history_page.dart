import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:share/share.dart';

import '../models/run_data.dart';
import '../screens/run_progress_page.dart';
import '../services/route_drawer.dart';
import '../widgets/custom_rounded_button.dart';
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.runData.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => Share.share(
                'Check out my ${widget.runData.distance} km run on jogzilla!'),
          )
        ],
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
                },
                styleString: MapboxStyles.LIGHT,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
              ),
              width: width,
              height: height * 0.65,
            ),
            RunSummaryHeader(
              runData: widget.runData,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomRoundedButton(
                  height: height * 0.08,
                  width: width * 0.1,
                  onTap: () => {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RunProgressPage.routeName,
                          (_) => false,
                          arguments: widget.runData.positions,
                        )
                      },
                  title: 'Run this route again',
                  color: Colors.lightBlueAccent),
            ),
          ],
        ),
      ),
    );
  }
}
