import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = 'settings_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
        ),
      ),
    );
  }
}
