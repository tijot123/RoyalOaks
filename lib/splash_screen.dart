import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login_screen.dart';
import 'common/common_bg_container.dart';
import 'helper/constants.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isUserLoggedIn().then((status) {
      if (status)
        moveToHomePage();
      else
        moveToLoginPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CommonBackgroundContainer(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: size.width / 3,
          height: size.height / 4,
          child: Image.asset(
            'assets/img/ball.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    ));
  }

  Future<bool> isUserLoggedIn() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    final prefs = await SharedPreferences.getInstance();
    var isLoggedIn = prefs.getBool(USER_LOGGED_IN);
    if (isLoggedIn == null)
      return false;
    else
      return isLoggedIn ? true : false;
  }

  void moveToHomePage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomeScreen(
              isGuest: false,
            )));
  }

  void moveToLoginPage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
  }
}
