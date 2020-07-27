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
      body: Container(
        // color: Theme.of(context).primaryColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 30,
                left: 20,
                bottom: 10,
              ),
              child: Text(
                'Account',
                style: TextStyle(fontSize: 15),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Card(
                margin: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FittedBox(
                        child: Icon(Icons.person),
                      ),
                    ),
                  ),
                  title: Text('Edit Profile'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Card(
                margin: EdgeInsets.only(
                  top: 5,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FittedBox(
                        child: Icon(Icons.vpn_key),
                      ),
                    ),
                  ),
                  title: Text('Change Password'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                bottom: 10,
              ),
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 15),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Card(
                margin: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FittedBox(
                        child: Icon(Icons.notifications),
                      ),
                    ),
                  ),
                  title: Text('Notifications'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Card(
                margin: EdgeInsets.only(
                  top: 5,
                  left: 10,
                  right: 10,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FittedBox(
                        child: Icon(Icons.volume_up),
                      ),
                    ),
                  ),
                  title: Text('Sounds'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Card(
                margin: EdgeInsets.only(
                  top: 5,
                  left: 10,
                  right: 10,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FittedBox(
                        child: Icon(Icons.question_answer),
                      ),
                    ),
                  ),
                  title: Text('Help and Support'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Card(
                margin: EdgeInsets.only(
                  top: 5,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FittedBox(
                        child: Icon(Icons.account_circle),
                      ),
                    ),
                  ),
                  title: Text('About'),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Card(
                margin: EdgeInsets.only(
                  top: 20,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: ListTile(
                  title: Center(
                    child: Text('Log out'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsMenuItem {
  Icon icon;
  String title;
  String description;

  SettingsMenuItem(this.icon, this.title, this.description);
}
