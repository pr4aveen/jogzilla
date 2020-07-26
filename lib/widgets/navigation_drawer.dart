import 'package:flutter/material.dart';

import '../screens/home_page.dart';
import '../screens/run_config_page.dart';
import '../screens/run_history_page.dart';
import '../screens/run_progress_page.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xff191f39),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 10),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 55,
              ),
            ),
            Text(
              'User Name',
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: Divider(color: Colors.grey[300]),
            ),
            NavigationDrawerItem(
              title: 'Home',
              icon: Icons.home,
              targetDestination: HomePage.routeName,
            ),
            NavigationDrawerItem(
              title: 'My Profile',
              icon: Icons.person,
            ),
            NavigationDrawerItem(
              title: 'Start New Run',
              icon: Icons.directions_run,
              targetDestination: RunProgressPage.routeName,
              pushAndRemoveUntil: true,
              arguments: {'route': const []},
            ),
            NavigationDrawerItem(
              title: 'Generate Route',
              icon: Icons.all_inclusive,
              targetDestination: RunConfigPage.routeName,
            ),
            NavigationDrawerItem(
              title: 'View Run History',
              icon: Icons.history,
              targetDestination: RunHistoryPage.routeName,
            ),
            NavigationDrawerItem(
              title: 'Settings',
              icon: Icons.settings,
            )
          ],
        ),
      ),
    );
  }
}

class NavigationDrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String targetDestination;
  final bool pushAndRemoveUntil;
  final Object arguments;

  NavigationDrawerItem({
    @required this.title,
    @required this.icon,
    this.targetDestination,
    this.arguments,
    this.pushAndRemoveUntil = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        if (pushAndRemoveUntil) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            targetDestination,
            (_) => false,
            arguments: arguments,
          );
        } else {
          Navigator.pushNamed(context, targetDestination);
        }
      },
    );
  }
}
