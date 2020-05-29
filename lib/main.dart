import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'pages/new_run_page.dart';
import 'pages/run_history_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogzilla',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Jogzilla'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _curPage = 0;
  List<String> _tabNames = ['Run History', 'New Run', 'Settings'];
  List<Widget> _pages = [RunHistoryPage(), NewRunPage(), SettingsPage()];
  String _pageName = 'Run History';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$_pageName',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).accentColor,
        elevation: 0.0,
      ),
      body: _pages[_curPage],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        animationCurve: Curves.linearToEaseOut,
        animationDuration: Duration(milliseconds: 300),
        buttonBackgroundColor: Theme.of(context).accentColor,
        color: Theme.of(context).accentColor,
        height: 55,
        items: <Widget>[
          Icon(Icons.list, size: 30, color: Colors.white,),
          Icon(Icons.add, size: 30, color: Colors.white),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _curPage = index;
            _pageName = _tabNames[index];
          });
        },
      ),
    );
  }
}
