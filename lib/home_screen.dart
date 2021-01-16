import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/api/api_provider.dart';
import 'package:flutter_app/common/common_snackbar.dart';
import 'package:flutter_app/common/loading_dialog.dart';
import 'package:flutter_app/helper/map_utils.dart';
import 'package:flutter_app/list_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  StreamSubscription<LocationData> streamSubscription;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    _checkLocationPermission();
    _getVersionData();
    if (!widget.isGuest) {
      streamSubscription = _location.onLocationChanged.listen((event) {
        var latitude = event.latitude;
        var longitude = event.longitude;
        var validArea = MapUtils.checkIfValidArea(
            LatLng(latitude, longitude), MapUtils.mainCoordinates);
        if (!validArea) {
          _deActivateUserSession();
        } else
          _activateUserSession(latitude, longitude);
      });
    }

    super.initState();
  }

  void _getVersionData() {
    PackageInfo.fromPlatform().then((value) {
      if (mounted)
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
                  if (!widget.isGuest) _deActivateUserSession();
                  value.setBool(USER_LOGGED_IN, false);
                  value.setString(USER_ID, "");
                  value.setString(SESSION_ID, "");
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  SizedBox(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          heightFactor: 3.8,
                          widthFactor: 2.0,
                          child: InkWell(
                            onTap: () {
                              _onTap(_teeTimes, context: context);
                            },
                            child: Image.asset(
                              "assets/img/tee_time.png",
                              height: 75,
                              width: 75,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          widthFactor: 3.5,
                          heightFactor: 2.8,
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
                        Align(
                          alignment: Alignment.topRight,
                          widthFactor: 3.5,
                          heightFactor: 2.8,
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
                        Align(
                          alignment: Alignment.bottomLeft,
                          heightFactor: 1.6,
                          widthFactor: 4.0,
                          child: InkWell(
                            onTap: () {
                              _onTap(_members, context: context);
                            },
                            child: Image.asset(
                              "assets/img/member.png",
                              height: 70,
                              width: 70,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              _onTap(_contactInfo, context: context);
                            },
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Image.asset(
                                "assets/img/contact_us_info.png",
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          heightFactor: 1.9,
                          widthFactor: 4.0,
                          child: InkWell(
                            onTap: () {
                              _onTap(_courseInfo, context: context);
                            },
                            child: Image.asset(
                              "assets/img/course_info.png",
                              height: 70,
                              width: 70,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          heightFactor: 3.8,
                          widthFactor: 2.5,
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
                        Align(
                          alignment: Alignment.bottomRight,
                          heightFactor: 3.8,
                          widthFactor: 2.2,
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
                  SizedBox(
                    height: 10,
                  )
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
    _activateUserSession(_locationData.latitude, _locationData.longitude);
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

  void _activateUserSession(double latitude, double longitude) {
    _checkLocationPermission();
    ApiProvider().activateUserSession().then((session) {
      SharedPreferences.getInstance().then((value) {
        value.setString(SESSION_ID, session.data[0].sessionId);
        ApiProvider().updateLocationToServer(latitude, longitude).then((value) {
          ApiProvider()
              .updateCurrentHoleToServer(latitude, longitude)
              .then((value) {});
        });
      });
    });
  }

  void _deActivateUserSession() {
    ApiProvider().deActivateUserSession().then((value) {});
  }

  @override
  void dispose() {
    if (!widget.isGuest) streamSubscription.cancel();
    super.dispose();
  }
}
