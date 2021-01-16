import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_provider.dart';
import 'package:flutter_app/common/common_bg_container.dart';
import 'package:flutter_app/common/common_snackbar.dart';
import 'package:flutter_app/common/loading_dialog.dart';
import 'package:flutter_app/helper/constants.dart';
import 'package:flutter_app/model/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _membershipController = TextEditingController();
  var _emailError = false;
  var _membershipNoError = false;

  var _loginKey = GlobalKey<State>();

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      var isShown = value.getBool(LOC_POP);
      if (isShown == null || isShown == false) {
        showLocationUpdatesAlert(
            message:
                "The Royal Oaks app needs to track your location when you are not using the app. The location is only transmitted to the club while you are on club property.");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);
    return CommonBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Builder(
          builder: (BuildContext context) {
            return SizedBox.expand(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/img/splash_logo.png",
                        height: size.height * 0.4,
                        width: size.width * 0.5,
                      ),
                      Container(
                        width: size.width / 1.2,
                        decoration: BoxDecoration(color: Colors.black),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: _membershipController,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => node.nextFocus(),
                            decoration: InputDecoration(
                                icon: Icon(Icons.card_membership),
                                border: InputBorder.none,
                                errorText: _membershipNoError
                                    ? "Type your membership ID"
                                    : null,
                                hintText: "Membership#"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: size.width / 1.2,
                        decoration: BoxDecoration(color: Colors.black),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
                          child: TextField(
                            controller: _emailController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.emailAddress,
                            onSubmitted: (_) => node.unfocus(),
                            decoration: InputDecoration(
                                icon: Icon(Icons.mail),
                                border: InputBorder.none,
                                errorText: _emailError
                                    ? "Type your registered email address"
                                    : null,
                                hintText: "Email address"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: size.width / 1.2,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0)),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            final email = _emailController.text;
                            final membershipNo = _membershipController.text;
                            if (membershipNo.isEmpty) {
                              if (mounted)
                                setState(() {
                                  _emailError = false;
                                  _membershipNoError = true;
                                });
                            } else if (email.isEmpty) {
                              if (mounted)
                                setState(() {
                                  _emailError = true;
                                  _membershipNoError = false;
                                });
                            } else {
                              _emailError = false;
                              _membershipNoError = false;
                              Dialogs.showLoadingDialog(context, _loginKey);
                              ApiProvider()
                                  .loginRequest(_membershipController.text,
                                      _emailController.text)
                                  .then((value) async {
                                Navigator.of(_loginKey.currentContext,
                                        rootNavigator: false)
                                    .pop();

                                LoginModel loginModel = value;
                                if (loginModel.data != null) {
                                  var sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  sharedPreferences.setString(
                                      USER_ID, loginModel.data.username);
                                  sharedPreferences.setString(
                                      UID, loginModel.data.userId);
                                  sharedPreferences.setBool(
                                      USER_LOGGED_IN, true);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              HomeScreen(
                                                isGuest: false,
                                              )));
                                } else
                                  CommonSnackBar.showSnackBar(
                                      context, loginModel.statusMessage);
                              }).catchError((error) {
                                Navigator.of(_loginKey.currentContext,
                                        rootNavigator: false)
                                    .pop();
                                CommonSnackBar.showSnackBar(
                                    context, "Sorry Connection Timed out");
                              });
                            }
                          },
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext context) => HomeScreen(
                                        isGuest: true,
                                      )));
                        },
                        child: Text(
                          "Login as Guest",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void showLocationUpdatesAlert({String message}) async {
    var instance = await SharedPreferences.getInstance();
    instance.setBool(LOC_POP, true);
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("Royal Oaks"),
            content: Text(
              '$message',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }
}
