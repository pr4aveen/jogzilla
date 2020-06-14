import 'package:flutter/material.dart';

import './screens/detailed_run_history_page.dart';
import './screens/run_history_page.dart';
import './screens/run_config_page.dart';
import './screens/settings_page.dart';

class RouteGenerator {
  static String initialRoute = RunHistoryPage.routeName;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case DetailedRunHistoryPage.routeName:
        return MaterialPageRoute(
            builder: (_) => DetailedRunHistoryPage(runData: args));
      case RunConfigPage.routeName:
        return MaterialPageRoute(
          builder: (_) => RunConfigPage(),
        );
      case RunHistoryPage.routeName:
        return MaterialPageRoute(builder: (_) => RunHistoryPage());
      case SettingsPage.routeName:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Center(
              child: Text('An error occured.'),
            ),
          ),
        );
    }
  }
}
