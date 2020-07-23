import 'package:flutter/material.dart';
import 'package:jogzilla/models/run_data.dart';
import 'package:jogzilla/widgets/overview_item.dart';

class RunSummary extends StatelessWidget {
  final RunData runData;
  RunSummary({
    @required this.runData,
    @required this.onSave,
    @required this.onDelete,
    @required this.modifyTitle,
    @required this.modifyDescription,
  });

  final Function onSave;
  final Function onDelete;

  final Function modifyTitle;
  final Function modifyDescription;

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                OverviewItem(
                    title: runData.duration, subtitle: 'DURATION', bold: false),
                OverviewItem(
                    title: runData.pace, subtitle: 'PACE', bold: false),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                labelText: 'Run Title',
              ),
              onChanged: modifyTitle,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                labelText: 'Description',
              ),
              onChanged: modifyDescription,
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
                alignment: Alignment.center,
                child: Text('Save Run'),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.lightGreen[300]),
              ),
              onTap: onSave,
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.4,
                alignment: Alignment.center,
                child: Text('Delete Run'),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.red[300]),
              ),
              onTap: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
