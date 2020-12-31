import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_provider.dart';
import 'package:flutter_app/common/common_snackbar.dart';
import 'package:flutter_app/common/loading_dialog.dart';
import 'package:flutter_app/list_screen.dart';
import 'package:location/location.dart';
import 'package:package_info/package_info.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'auth/login_screen.dart';
import 'common/common_bg_container.dart';
import 'contact_us_screen.dart';
import 'courseInfo/course_info_screen.dart';
import 'event/event_screen.dart';
import 'food_order_screen.dart';
import 'gps/location_screen.dart';
import 'helper/constants.dart';
import 'member/member_list_screen.dart';
import 'teetimes/tee_times_screen.dart';
import 'yard/yard_guide_screen.dart';

class HomeScreen extends StatefulWidget {
  final isGuest;

  const HomeScreen({Key key, @required this.isGuest}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _teeTimes = "TeeTimes";
  static const _gps = "gps";
  static const _courseInfo = "CourseInfo";
  static const _event = "Event";
  static const _yardGuide = "YardGuide";
  static const _members = "Members";
  static const _orderFood = "OrderFood";
  static const _contactInfo = "ContactInfo";
  Location _location = Location();
  PermissionStatus _permissionStatus;
  LocationData _locationData;
  var _serviceEnabled = false;
  var _version = "";

  final _homeKey = GlobalKey<State>();

  @override
  void initState() {
    _checkLocationPermission();
    _getVersionData();

    _location.onLocationChanged.listen((event) {

    });
    super.initState();
  }

  void _getVersionData() {
    PackageInfo.fromPlatform().then((value) {
      setState(() {
        _version = "Version ${value.version}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Dashboard"),
          actions: [
            IconButton(
              onPressed: () {
                SharedPreferences.getInstance().then((value) {
                  value.setBool(USER_LOGGED_IN, false);
                  value.setString(USER_ID, "");
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()));
                });
              },
              icon: Icon(Icons.exit_to_app),
            )
          ],
        ),
        body: Builder(
          builder: (BuildContext context) {
            return SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _version,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Image.asset(
                      "assets/img/splash_logo.png",
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: InkWell(
                        onTap: () {
                          _onTap(_teeTimes, context: context);
                        },
                        child: Image.asset(
                          "assets/img/tee_time.png",
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              _onTap(_orderFood, context: context);
                            },
                            child: Image.asset(
                              "assets/img/order_food.png",
                              height: 70,
                              width: 70,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              _onTap(_gps, context: context);
                            },
                            child: Image.asset(
                              "assets/img/gps.png",
                              height: 70,
                              width: 70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: InkWell(
                              onTap: () {
                                _onTap(_members, context: context);
                              },
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.asset(
                                    "assets/img/member.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                            child: InkWell(
                              onTap: () {
                                _onTap(_contactInfo, context: context);
                              },
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.asset(
                                    "assets/img/contact_us_info.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: InkWell(
                              onTap: () {
                                _onTap(_courseInfo, context: context);
                              },
                              child: SizedBox(
                                height: 70,
                                width: 70,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.asset(
                                    "assets/img/course_info.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: InkWell(
                            onTap: () {
                              _onTap(_yardGuide, context: context);
                            },
                            child: Image.asset(
                              "assets/img/yard_guide.png",
                              height: 70,
                              width: 70,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 60,
                        ),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              _onTap(_event, context: context);
                            },
                            child: Image.asset(
                              "assets/img/event.png",
                              height: 70,
                              width: 70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                        color: Colors.white),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => ListScreen()));
                      },
                      child: Text(
                        "Golf Shop & Tournament Information",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _onTap(String id, {context}) {
    switch (id) {
      case _teeTimes:
        if (widget.isGuest) {
          showGuestNotAllowedAlert(message: "Guest user not authorized");
        } else {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => TeeTimesScreen()));
        }
        break;
      case _gps:
        if (_locationData != null)
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => LocationScreen(
                    locationData: _locationData,
                  )));
        else
          _checkLocationPermission();
        break;
      case _courseInfo:
        {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => CourseInfoScreen()));
        }
        break;
      case _event:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => EventScreen()));
        break;
      case _yardGuide:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => YardGuideScreen()));
        break;
      case _members:
        {
          if (widget.isGuest) {
            showGuestNotAllowedAlert(
                message: "Guest user can not view member list");
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MemberListScreen()));
          }
        }
        break;
      case _orderFood:
        {
          if (widget.isGuest) {
            showGuestNotAllowedAlert(message: "Guest user can not place order");
          } else {
            Dialogs.showLoadingDialog(context, _homeKey);
            ApiProvider().fetchLatestOrderFoodUrl().then((value) {
              Navigator.of(_homeKey.currentContext, rootNavigator: false).pop();
              String foodUrl = value.data.golfFoodUrl;
              if (foodUrl != null) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => FoodOrderScreen(
                          foodUrl: foodUrl,
                        )));
              } else
                CommonSnackBar.showSnackBar(
                    context, "Sorry food ordering not available right now..");
            }).catchError((error) {
              Navigator.of(_homeKey.currentContext, rootNavigator: false).pop();
              CommonSnackBar.showSnackBar(context, error.toString());
            });
          }
        }
        break;
      case _contactInfo:
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ContactUsScreen()));
        break;
    }
  }

  void _checkLocationPermission() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();
      if (_permissionStatus != PermissionStatus.granted) return;
    }
    _locationData = await _location.getLocation();
    debugPrint(_locationData.toString());
  }

  void showGuestNotAllowedAlert({String message}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.white,
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
