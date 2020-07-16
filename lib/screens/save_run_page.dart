import 'package:flutter/material.dart';

import '../models/run_data.dart';

class SaveRunPage extends StatefulWidget {
  static const String routeName = 'SaveRunPage';

  SaveRunPage({
    @required RunData runData,
  });

  @override
  _SaveRunPageState createState() => _SaveRunPageState();
}

class _SaveRunPageState extends State<SaveRunPage> {
  String runTitle;
  String runDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Save Run',
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Run Title',
              ),
              onChanged: (text) => runTitle = text,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              onChanged: (text) => runDescription = text,
            ),
            RaisedButton(
              child: Text('Save Run'),
              onPressed: () {
                print(runTitle);
                print(runDescription);
              },
            )
          ],
        ),
      ),
    );
  }
}
