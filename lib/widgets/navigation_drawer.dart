import 'package:flutter/material.dart';

import '../screens/run_config_page.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
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
              style: Theme.of(context).textTheme.headline6,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              child: Divider(color: Colors.grey[300]),
            ),
            NavigationDrawerItem(
              title: 'My Profile',
              icon: Icons.person,
            ),
            NavigationDrawerItem(
              title: 'New Run',
              icon: Icons.directions_run,
              targetDestination: RunConfigPage.routeName,
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

  NavigationDrawerItem(
      {@required this.title, @required this.icon, this.targetDestination});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(fontSize: 18.0),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, targetDestination);
      },
    );
  }
}
