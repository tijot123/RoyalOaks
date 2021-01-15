import 'dart:convert';

SessionModel sessionModelFromJson(String str) => SessionModel.fromJson(json.decode(str));

String sessionModelToJson(SessionModel data) => json.encode(data.toJson());

class SessionModel {
  SessionModel({
    this.status,
    this.statusMessage,
    this.data,
  });

  int status;
  String statusMessage;
  List<Datum> data;

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
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
    this.sessionId,
    this.sessionStatus,
  });

  String sessionId;
  String sessionStatus;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    sessionId: json["SESSION_ID"] == null ? null : json["SESSION_ID"],
    sessionStatus: json["SESSION_STATUS"] == null ? null : json["SESSION_STATUS"],
  );

  Map<String, dynamic> toJson() => {
    "SESSION_ID": sessionId == null ? null : sessionId,
    "SESSION_STATUS": sessionStatus == null ? null : sessionStatus,
  };
}
