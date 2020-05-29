import 'package:flutter/material.dart';

class NewRunPage extends StatelessWidget {

  final String _pageName = 'New Run';

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_pageName',
              style: TextStyle(color: Colors.teal, fontSize: 32),
            )
          ],
        ),
    );
  }
}