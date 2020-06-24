import 'package:flutter/material.dart';
import 'package:jogzilla/screens/run_progress_page.dart';

class RunConfigPage extends StatelessWidget {
  static const String routeName = 'run_config_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Start New Run',
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () =>
              Navigator.pushNamed(context, RunProgressPage.routeName)),
    );
  }
}
