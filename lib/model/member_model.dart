import 'dart:convert';

MemberModel memberModelFromJson(String str) => MemberModel.fromJson(json.decode(str));

String memberModelToJson(MemberModel data) => json.encode(data.toJson());

class MemberModel {
  MemberModel({
    this.status,
    this.statusMessage,
    this.data,
  });

  int status;
  String statusMessage;
  List<Datum> data;

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
    status: json["status"] == null ? null : json["status"],
    statusMessage: json["status_message"] == null ? null : json["status_message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "status_message": statusMessage == null ? null : statusMessage,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.userId,
    this.displayName,
    this.email,
    this.cellPhone,
    this.homePhone,
    this.profilePhoto,
  });

  String userId;
  String displayName;
  String email;
  String cellPhone;
  String homePhone;
  String profilePhoto;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    userId: json["user_id"] == null ? null : json["user_id"],
    displayName: json["display_name"] == null ? null : json["display_name"],
    email: json["email"] == null ? null : json["email"],
    cellPhone: json["cellPhone"] == null ? null : json["cellPhone"],
    homePhone: json["homePhone"] == null ? null : json["homePhone"],
    profilePhoto: json["profilePhoto"] == null ? null : json["profilePhoto"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "display_name": displayName == null ? null : displayName,
    "email": email == null ? null : email,
    "cellPhone": cellPhone == null ? null : cellPhone,
    "homePhone": homePhone == null ? null : homePhone,
    "profilePhoto": profilePhoto == null ? null : profilePhoto,
  };
}
