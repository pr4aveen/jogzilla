import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/run_data.dart';
import '../screens/detailed_run_history_page.dart';
import './run_data_item.dart';

class RunHistoryTile extends StatelessWidget {
  final RunData data;
  RunHistoryTile({this.data});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(data.dateTime);
    String dateString = DateFormat('dd MMM yyyy h:mm a').format(dateTime);

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(DetailedRunHistoryPage.routeName, arguments: data);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 15.0,
          right: 15.0,
          bottom: 0.0,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(data.title,
                            style: Theme.of(context).textTheme.headline6),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(dateString,
                            style: Theme.of(context).textTheme.caption),
                        SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            RunDataItem(
                              label: 'Distance',
                              value: data.distance,
                            ),
                            Container(
                              height: 35,
                              child: VerticalDivider(color: Colors.grey[850]),
                            ),
                            RunDataItem(
                              label: 'Pace',
                              value: data.pace,
                            ),
                            Container(
                              height: 35,
                              child: VerticalDivider(color: Colors.grey[850]),
                            ),
                            RunDataItem(
                              label: 'Time',
                              value: data.duration,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
