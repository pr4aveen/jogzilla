import 'package:flutter/material.dart';
import '../models/run_data.dart';

class RunHistoryTile extends StatelessWidget {
  final RunData data;
  RunHistoryTile({this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        color: Colors.grey[850],
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        data.description,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        data.dateTime,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RunDataItem(
                              label: 'Distance',
                              value: data.distance,
                            ),
                          ),
                          Expanded(
                            child: RunDataItem(
                              label: 'Pace',
                              value: data.pace,
                            ),
                          ),
                          Expanded(
                            child: RunDataItem(
                              label: 'Time',
                              value: data.duration,
                            ),
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
    );
  }
}

class RunDataItem extends StatelessWidget {
  final String label;
  final String value;

  RunDataItem({@required this.label, @required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(color: Colors.grey.shade500),
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
