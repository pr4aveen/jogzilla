import 'package:flutter/material.dart';
import 'package:jogzilla/models/run_data.dart';

class RunSummary extends StatelessWidget {
  final RunData runData;
  RunSummary({@required this.runData});

  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'RUN SUMMARY',
                style: const TextStyle(
                    fontSize: 21,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
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
                runData.distance + ' km',
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Column(children: <Widget>[
                    Text(runData.duration,
                        style: const TextStyle(fontSize: 30)),
                    Text(
                      'DURATION',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ]),
                ),
                Container(
                  child: Column(children: <Widget>[
                    Text(runData.pace, style: const TextStyle(fontSize: 30)),
                    Text(
                      'PACE',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ]),
                ),
              ],
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
