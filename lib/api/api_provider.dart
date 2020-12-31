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
      return OrderFoodModel.fromJson(jsonDecode(response.body.replaceRange(0, 3, "")));
    } else {
      throw Exception('Food Url Fetching Failed');
    }
  }
}
