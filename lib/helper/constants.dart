import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const USER_LOGGED_IN = "user_logged_in";
const USER_ID = "userId";
const UID = "user_id";
const SESSION_ID = "session_id";
const FCM_TOKEN = "tokenId";
const LOC_POP = "location_pop";

void showLocationUpdatesAlert({String message, BuildContext context}) async {
  var instance = await SharedPreferences.getInstance();
  instance.setBool(LOC_POP, true);
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Royal Oaks",style: TextStyle(color: Colors.black),),
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
