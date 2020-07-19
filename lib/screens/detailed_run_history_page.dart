import 'package:flutter/material.dart';

import '../models/run_data.dart';

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
    );
  }
}
