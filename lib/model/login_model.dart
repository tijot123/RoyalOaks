import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.status,
    this.statusMessage,
    this.data,
  });

  int status;
  String statusMessage;
  Data data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"] == null ? null : json["status"],
    statusMessage: json["status_message"] == null ? null : json["status_message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "status_message": statusMessage == null ? null : statusMessage,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.userId,
    this.username,
    this.email,
    this.displayName,
    this.status,
    this.password,
  });

  String userId;
  String username;
  String email;
  String displayName;
  String status;
  String password;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"] == null ? null : json["user_id"],
    username: json["username"] == null ? null : json["username"],
    email: json["email"] == null ? null : json["email"],
    displayName: json["display_name"] == null ? null : json["display_name"],
    status: json["status"] == null ? null : json["status"],
    password: json["password"] == null ? null : json["password"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "username": username == null ? null : username,
    "email": email == null ? null : email,
    "display_name": displayName == null ? null : displayName,
    "status": status == null ? null : status,
    "password": password == null ? null : password,
  };
}
