import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app/api/api_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future<void> init() async {
    // For iOS request permission first.
    if (Platform.isIOS) _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
      },
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = await _firebaseMessaging.getToken();
    prefs.setString(FCM_TOKEN, token);
    print("FirebaseMessaging token: $token");
    ApiProvider().updateFcmTokenToServer().then((value) {});
    _firebaseMessaging.onTokenRefresh.listen((event) {
      String token = event;
      prefs.setString(FCM_TOKEN, token);
      print("FirebaseMessaging onTokenRefresh: $token");
      ApiProvider().updateFcmTokenToServer().then((value) {});
    });
  }

  void _showItemDialog(Map<String, dynamic> message) async {
    var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var title = "";
    var msg = "";
    if (message.containsKey("data")) {
      title = "Royal Oaks";
      msg = message["data"]["message"] != null
          ? message["data"]["message"]
          : message["notification"]["body"];
    } else {
      if (Platform.isIOS) {
        title = message["aps"]["alert"]["title"];
        msg = message["aps"]["alert"]["body"];
      } else {
        title = message["notification"]["title"];
        msg = message["notification"]["body"];
      }
    }
    var android = AndroidNotificationDetails('id', 'channel ', 'description',
        priority: Priority.max,
        importance: Importance.max,
        icon: 'mipmap/ic_launcher');
    var iOS = IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        sound: 'default',
        presentSound: true);
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(0, title, msg, platform);
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {}
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print("myBackgroundMessageHandler: $message");
  return null;
}
