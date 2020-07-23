import 'package:flutter/material.dart';
import 'package:jogzilla/screens/run_history_page.dart';
import 'package:jogzilla/services/database_storage.dart';
import 'package:jogzilla/services/route_drawer.dart';
import 'package:jogzilla/widgets/run_summary.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../models/run_data.dart';

class SaveRunPage extends StatefulWidget {
  static const String routeName = 'SaveRunPage';
  final RunData runData;

  SaveRunPage({@required this.runData});

  @override
  _SaveRunPageState createState() => _SaveRunPageState();
}

class _SaveRunPageState extends State<SaveRunPage> {
  String runTitle;
  String runDescription;
  MapboxMapController mapController;

  final DatabaseStorage storage = DatabaseStorage.instance;

  void _saveRunData() {
    widget.runData.title = runTitle == null ? '' : runTitle;
    widget.runData.description = runDescription == null ? '' : runDescription;
    storage.insert(widget.runData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Save Run',
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              child: MapboxMap(
                onMapCreated: (controller) {
                  RouteDrawer.drawRoute(
                      route: widget.runData.positions, controller: controller);
                },
                initialCameraPosition: CameraPosition(
                    target: widget.runData.positions.isEmpty
                        ? LatLng(1.2839, 103.8607)
                        : widget.runData.positions[0],
                    zoom: 14),
                styleString: MapboxStyles.LIGHT,
                rotateGesturesEnabled: false,
                tiltGesturesEnabled: false,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
            ),
            RunSummary(
              runData: widget.runData,
              onSave: () {
                _saveRunData();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RunHistoryPage.routeName, (_) => false);
                print(runTitle);
                print(runDescription);
              },
              onDelete: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  RunHistoryPage.routeName, (_) => false),
              modifyTitle: (text) => runTitle = text,
              modifyDescription: (text) => runDescription = text,
            ),
          ],
        ),
      ),
    );
  }
}
