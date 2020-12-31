import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'splash_screen.dart';

void main() {

/*  if(Platform.isAndroid)
    // ignore: invalid_use_of_visible_for_testing_member
  SharedPreferences.setMockInitialValues({});*/
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
          primaryColor: Color.fromRGBO(51, 107, 2, 1),
          primaryColorDark: Color.fromRGBO(43, 91, 1, 1),
          accentColor: Color.fromRGBO(104, 159, 56, 1),
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
