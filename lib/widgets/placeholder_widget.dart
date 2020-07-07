import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget(
      {@required this.title, @required this.message, this.reversed = false});

  final String title;
  final String message;
  final bool reversed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(title,
              style: reversed
                  ? const TextStyle(fontSize: 16.0)
                  : const TextStyle(fontSize: 32.0),
              textAlign: TextAlign.center),
          Text(message,
              style: reversed
                  ? const TextStyle(fontSize: 32.0)
                  : const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
