import 'package:flutter/material.dart';

import '../constants.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          color: kDarkBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 10),
                child: CircleAvatar(
                  backgroundColor: kRedAccent,
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
                child: Divider(color: Colors.grey),
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text(
                  'My Profile',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.directions_run, color: Colors.white),
                title: Text(
                  'New Run',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              )
            ],
          )),
    );
  }
}
