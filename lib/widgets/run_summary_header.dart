import 'package:flutter/material.dart';

import './overview_item.dart';
import '../models/run_data.dart';

class RunSummaryHeader extends StatelessWidget {
  final RunData runData;

  RunSummaryHeader({this.runData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'RUN SUMMARY',
            style: const TextStyle(
                fontSize: 21, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(
          color: Colors.grey[850],
          height: 0,
          thickness: 1,
          indent: 0,
          endIndent: 0,
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 40,
          ),
          child: Text(
            runData.distance.toString() + ' km',
            style: const TextStyle(
              fontSize: 60,
            ),
          ),
        ),
        Text(
          'DISTANCE',
          style: const TextStyle(fontSize: 15),
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            OverviewItem(
                title: runData.duration.toString(),
                subtitle: 'DURATION',
                bold: false),
            OverviewItem(
                title: runData.pace.toString(), subtitle: 'PACE', bold: false),
            OverviewItem(
                title: runData.calories.toString(),
                subtitle: 'CALORIES',
                bold: false),
          ],
        ),
      ],
    );
  }
}
