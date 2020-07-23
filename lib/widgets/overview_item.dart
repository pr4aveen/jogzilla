import 'package:flutter/material.dart';

class OverviewItem extends StatelessWidget {
  const OverviewItem(
      {@required this.title, @required this.subtitle, this.bold = true});

  final String title;
  final String subtitle;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontSize: 32.0,
                color: Colors.black,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
