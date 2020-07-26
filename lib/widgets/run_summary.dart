import 'package:flutter/material.dart';
import 'package:jogzilla/widgets/run_summary_header.dart';

import '../models/run_data.dart';
import '../widgets/run_summary_header.dart';

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            RunSummaryHeader(
              runData: runData,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                labelText: 'Run Title (optional)',
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
                labelText: 'Description (optional)',
              ),
              onChanged: modifyDescription,
            ),
            SizedBox(
              height: 20,
            ),
            CustomRoundedButton(
              height: height * 0.06,
              width: width * 0.8,
              onTap: onSave,
              title: 'Save Run',
              color: Colors.lightGreen[300],
            ),
            SizedBox(
              height: 10,
            ),
            CustomRoundedButton(
              height: height * 0.05,
              width: width * 0.4,
              onTap: onDelete,
              title: 'Delete Run',
              color: Colors.red[300],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.onTap,
      @required this.title,
      @required this.color})
      : super(key: key);

  final double height;
  final double width;
  final Function onTap;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        child: Text(title),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: color),
      ),
      onTap: onTap,
    );
  }
}
