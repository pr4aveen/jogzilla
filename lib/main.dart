import 'package:flutter/material.dart';

import './screens/run_history_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogzilla',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFEB3153),
        accentColor: Color(0xFF212121),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RunHistory(),
    );
  }
}
