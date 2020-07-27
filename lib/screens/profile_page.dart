import 'package:flutter/material.dart';
import 'package:jogzilla/services/database_storage.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = 'profile_page';
  final DatabaseStorage storage = DatabaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Container(
        // color: Theme.of(context).primaryColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 30),
                    child: CircleAvatar(
                      child: Icon(
                        Icons.person,
                        size: 150,
                        color: Colors.grey[300],
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 80,
                    ),
                  ),
                  Text(
                    'User Name',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
            Divider(
              height: 50,
              color: Colors.grey[800],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 40,
                bottom: 5,
              ),
              child: Text(
                'Gender:',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 40,
                bottom: 10,
              ),
              child: Text(
                'Male',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              height: 30,
              indent: 30,
              endIndent: 30,
              color: Colors.grey[800],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 40,
                bottom: 5,
              ),
              child: Text(
                'Height:',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 40,
                bottom: 10,
              ),
              child: Text(
                '170 cm',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(
              height: 30,
              indent: 30,
              endIndent: 30,
              color: Colors.grey[800],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 40,
                bottom: 5,
              ),
              child: Text(
                'Weight:',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 40,
                bottom: 10,
              ),
              child: Text(
                '60 kg',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
