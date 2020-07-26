import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:intl/intl.dart';

import '../models/run_data.dart';
import '../screens/run_history_page.dart';
import '../services/database_storage.dart';
import '../services/route_drawer.dart';
import '../widgets/run_summary.dart';

class SaveRunPage extends StatefulWidget {
  static const String routeName = 'SaveRunPage';
  final RunData runData;

  SaveRunPage({@required this.runData});

  @override
  _SaveRunPageState createState() => _SaveRunPageState();
}

class _SaveRunPageState extends State<SaveRunPage> {
  String _runTitle;
  String _runDescription;
  MapboxMapController mapController;

  final DatabaseStorage _storage = DatabaseStorage.instance;

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  void _saveRunData() {
    widget.runData.title = _runTitle == null ? _defaultTitle : _runTitle;
    widget.runData.description = _runDescription == null ? '' : _runDescription;
    _storage.insert(widget.runData);
  }

  String get _defaultTitle {
    DateTime dateTime = DateTime.now();
    String day = DateFormat("EEEE").format(dateTime);
    int hour = int.parse(DateFormat("H").format(dateTime));

    if (hour < 12) {
      return '$day Morning Run';
    } else if (hour < 18) {
      return '$day Afternoon Run';
    } else {
      return '$day Evening Run';
    }
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
                initialCameraPosition:
                    CameraPosition(target: LatLng(0, 0), zoom: 14),
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
              },
              onDelete: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  RunHistoryPage.routeName, (_) => false),
              modifyTitle: (text) => _runTitle = text,
              modifyDescription: (text) => _runDescription = text,
            ),
          ],
        ),
      ),
    );
  }
}
