import 'package:flutter/material.dart';

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
    );
  }
}
