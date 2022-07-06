import 'package:flutter/material.dart';

import 'splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _fontFamily = "open sans";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Royal Oaks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color.fromRGBO(42, 42, 42, 1),
          primaryColorDark: Color.fromRGBO(42, 42, 42, 1),
          accentColor: Color.fromRGBO(42, 42, 42, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: TextTheme(
            bodyText2: TextStyle(
              fontFamily: _fontFamily,
            ),
          ),
          fontFamily: _fontFamily),
      home: SplashScreen(),
    );
  }
}
