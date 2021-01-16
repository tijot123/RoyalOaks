import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/helper/constants.dart';
import 'package:flutter_app/model/button_info_model.dart';
import 'package:flutter_app/model/coordinates_model.dart';
import 'package:flutter_app/model/events_model.dart';
import 'package:flutter_app/model/food_order_model.dart';
import 'package:flutter_app/model/login_model.dart';
import 'package:flutter_app/model/member_details_model.dart';
import 'package:flutter_app/model/member_model.dart';
import 'package:flutter_app/model/session_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  final baseUrl = "http://golf.pacetracker.net/royaloaks/golf/api.php";

  Future<LoginModel> loginRequest(String membershipNo, String email) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    final deviceToken = sharedPreferences.getString(FCM_TOKEN);
    final response = await http.get(
        '$baseUrl?f=User_Login&uname=$membershipNo&pwd=$email&device_token=$deviceToken&device_type=A');
    if (response.statusCode == 200) {
      debugPrint(response.body.replaceRange(0, 3, ""));
      return LoginModel.fromJson(
          jsonDecode(response.body.replaceRange(0, 3, "")));
    } else {
      throw Exception('Login Failed');
    }
  }

  Future<MemberModel> membersRequest() async {
    final response = await http.get('$baseUrl?f=All_Users_List');
    if (response.statusCode == 200) {
      debugPrint(response.body.replaceRange(0, 3, ""));
      return MemberModel.fromJson(
          jsonDecode(response.body.replaceRange(0, 3, "")));
    } else {
      throw Exception('Members List Fetching Failed');
    }
  }

  Future<CoordinatesModel> coordinatesRequest() async {
    final response = await http.get('$baseUrl?f=Get_Holes_Coordinates');
    if (response.statusCode == 200) {
      debugPrint(response.body.replaceRange(0, 3, ""));
      return CoordinatesModel.fromJson(
          jsonDecode(response.body.replaceRange(0, 3, "")));
    } else {
      throw Exception('Coordinates List Fetching Failed');
    }
  }

  Future<EventsModel> eventsRequest() async {
    final response = await http.get('$baseUrl?f=Get_Events&status=active');
    if (response.statusCode == 200) {
      debugPrint(response.body.replaceRange(0, 3, ""));
      return EventsModel.fromJson(
          jsonDecode(response.body.replaceRange(0, 3, "")));
    } else {
      throw Exception('Events List Fetching Failed');
    }
  }

  Future<MemberDetailsModel> requestMemberDetails(String userId) async {
    debugPrint('$baseUrl?f=User_Detail_Info&userid=$userId');
    final response =
        await http.get('$baseUrl?f=User_Detail_Info&userid=$userId');
    if (response.statusCode == 200) {
      debugPrint(response.body.replaceRange(0, 3, ""));
      return MemberDetailsModel.fromJson(
          jsonDecode(response.body.replaceRange(0, 3, "")));
    } else {
      throw Exception('Events List Fetching Failed');
    }
  }

  Future<ButtonInfoModel> requestButtonInfo() async {
    debugPrint('$baseUrl?f=button_info');
    final response = await http.get('$baseUrl?f=button_info');
    if (response.statusCode == 200) {
      debugPrint(response.body.replaceRange(0, 3, ""));
      return ButtonInfoModel.fromJson(
          jsonDecode(response.body.replaceRange(0, 3, "")));
    } else {
      throw Exception('Info Fetching Failed');
    }
  }

  Future<OrderFoodModel> fetchLatestOrderFoodUrl() async {
    debugPrint('$baseUrl?f=Order_Food_Url');
    final response = await http.get('$baseUrl?f=Order_Food_Url');
    if (response.statusCode == 200) {
      debugPrint(response.body.replaceRange(0, 3, ""));
      return OrderFoodModel.fromJson(
          jsonDecode(response.body.replaceRange(0, 3, "")));
    } else {
      throw Exception('Food Url Fetching Failed');
    }
  }

  Future<SessionModel> activateUserSession() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    debugPrint(
        '$baseUrl?f=Activate_Session&user=${sharedPreferences.getString(USER_ID)}');
    final response = await http.get(
        '$baseUrl?f=Activate_Session&user=${sharedPreferences.getString(USER_ID)}');
    if (response.statusCode == 200) {
      debugPrint(response.body.replaceRange(0, 3, ""));
      return SessionModel.fromJson(
          jsonDecode(response.body.replaceRange(0, 3, "")));
    } else {
      throw Exception('Activating User Session Failed');
    }
  }

  Future<SessionModel> deActivateUserSession() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    debugPrint(
        '$baseUrl?f=Deactivate_Session&sid=${sharedPreferences.getString(SESSION_ID)}');
    final response = await http.get(
        '$baseUrl?f=Deactivate_Session&sid=${sharedPreferences.getString(SESSION_ID)}');
    if (response.statusCode == 200) {
      debugPrint(response.body.replaceRange(0, 3, ""));
      return SessionModel.fromJson(
          jsonDecode(response.body.replaceRange(0, 3, "")));
    } else {
      throw Exception('DeActivating User Session Failed');
    }
  }

  Future<dynamic> updateFcmTokenToServer() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    debugPrint(
        '$baseUrl?f=Device_Token&user_id=${sharedPreferences.getString(UID)}&device_type=A&device_token=${sharedPreferences.getString(FCM_TOKEN)}');
    final response = await http.get(
        '$baseUrl?f=Device_Token&user_id=${sharedPreferences.getString(UID)}&device_type=A&device_token=${sharedPreferences.getString(FCM_TOKEN)}');
    if (response.statusCode == 200) {
      debugPrint(response.body.replaceRange(0, 3, ""));
      return response.body.replaceRange(0, 3, "");
    } else {
      throw Exception('updateFcmTokenToServer Failed');
    }
  }

  Future<dynamic> updateLocationToServer(latitude,longitude) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    debugPrint(
        '$baseUrl?f=Update_Latlong&sid=${sharedPreferences.getString(SESSION_ID)}&usr=${sharedPreferences.getString(USER_ID)}&lat=$latitude&long=$longitude');
    final response = await http.get(
        '$baseUrl?f=Update_Latlong&sid=${sharedPreferences.getString(SESSION_ID)}&usr=${sharedPreferences.getString(USER_ID)}&lat=$latitude&long=$longitude');
    if (response.statusCode == 200) {
      debugPrint(response.body.replaceRange(0, 3, ""));
      return response.body.replaceRange(0, 3, "");
    } else {
      throw Exception('updateLocationToServer Failed');
    }
  }

  Future<dynamic> updateCurrentHoleToServer(latitude,longitude) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    debugPrint(
        '$baseUrl?f=Update_Hole_No&sid=${sharedPreferences.getString(SESSION_ID)}&usr=${sharedPreferences.getString(USER_ID)}&hole=1&lat=$latitude&long=$longitude');
    final response = await http.get(
        '$baseUrl?f=Update_Hole_No&sid=${sharedPreferences.getString(SESSION_ID)}&usr=${sharedPreferences.getString(USER_ID)}&hole=1&lat=$latitude&long=$longitude');
    if (response.statusCode == 200) {
      debugPrint(response.body.replaceRange(0, 3, ""));
      return response.body.replaceRange(0, 3, "");
    } else {
      throw Exception('updateLocationToServer Failed');
    }
  }
}
