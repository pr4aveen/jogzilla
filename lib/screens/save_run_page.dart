import 'package:flutter/material.dart';
import 'package:jogzilla/screens/run_history_page.dart';
import 'package:jogzilla/services/database_storage.dart';

import '../models/run_data.dart';

class SaveRunPage extends StatefulWidget {
  static const String routeName = 'SaveRunPage';
  final RunData runData;

  SaveRunPage({@required this.runData});

  @override
  _SaveRunPageState createState() => _SaveRunPageState();
}

class _SaveRunPageState extends State<SaveRunPage> {
  String runTitle;
  String runDescription;

  final DatabaseStorage storage = DatabaseStorage.instance;

  void _saveRunData() {
    widget.runData.title = runTitle;
    widget.runData.description = runDescription;
    storage.insert(widget.runData);
  }

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
                _saveRunData();
                Navigator.of(context).pushNamed(RunHistoryPage.routeName);
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
