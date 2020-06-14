import 'package:flutter/material.dart';

import '../models/run_data.dart';
import '../constants.dart';

class DetailedRunHistory extends StatelessWidget {
  final RunData runData;

  DetailedRunHistory({@required this.runData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(runData.description),
      ),
      backgroundColor: kDarkBackground,
    );
  }
}
