import 'package:flutter/material.dart';

import '../screens/detailed_run_history_page.dart';
import '../screens/home_page.dart';
import '../screens/run_config_page.dart';
import '../screens/run_history_page.dart';
import '../screens/run_progress_page.dart';
import '../screens/save_run_page.dart';
import '../screens/settings_page.dart';

class RouteGenerator {
  static String initialRoute = HomePage.routeName;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );
      case DetailedRunHistoryPage.routeName:
        return MaterialPageRoute(
          builder: (_) => DetailedRunHistoryPage(
            runData: args,
          ),
        );
      case RunConfigPage.routeName:
        return MaterialPageRoute(
          builder: (_) => RunConfigPage(),
        );
      case RunProgressPage.routeName:
        return MaterialPageRoute(
          builder: (_) => RunProgressPage(),
        );
      case RunHistoryPage.routeName:
        return MaterialPageRoute(
          builder: (_) => RunHistoryPage(),
        );
      case SaveRunPage.routeName:
        return MaterialPageRoute(
          builder: (_) => SaveRunPage(
            runData: args,
          ),
        );
      case SettingsPage.routeName:
        return MaterialPageRoute(
          builder: (_) => SettingsPage(),
        );
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
