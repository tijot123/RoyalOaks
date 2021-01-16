import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app/api/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
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
      _initialized = true;
    }
  }

  void _showItemDialog(Map<String, dynamic> message) {}

  void _navigateToItemDetail(Map<String, dynamic> message) {}
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {}
