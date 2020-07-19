import 'package:flutter/material.dart';

import './services/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color blackBackground = Color(0xFF212121);
  final Color greyAccent = Color(0xFF5D5D5D);
  final Color redAccent = Color(0xFFEB3153);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteGenerator.initialRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
      title: 'Jogzilla',
      theme: ThemeData(
        accentColor: greyAccent,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: Colors.lightBlueAccent,
        ),
        backgroundColor: blackBackground,
        primaryColor: redAccent,
        scaffoldBackgroundColor: Colors.grey[200],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
