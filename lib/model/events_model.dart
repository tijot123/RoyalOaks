import 'dart:convert';

EventsModel eventsModelFromJson(String str) => EventsModel.fromJson(json.decode(str));

String eventsModelToJson(EventsModel data) => json.encode(data.toJson());

class EventsModel {
  EventsModel({
    this.status,
    this.statusMessage,
    this.data,
  });

  int status;
  String statusMessage;
  List<Datum> data;

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
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
    this.eventId,
    this.eventTitle,
    this.eventDescription,
    this.eventDate,
    this.eventTime,
    this.eventVenue,
    this.eventStatus,
    this.eventRemarks,
  });

  String eventId;
  String eventTitle;
  String eventDescription;
  DateTime eventDate;
  String eventTime;
  String eventVenue;
  String eventStatus;
  String eventRemarks;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    eventId: json["EVENT_ID"] == null ? null : json["EVENT_ID"],
    eventTitle: json["EVENT_TITLE"] == null ? null : json["EVENT_TITLE"],
    eventDescription: json["EVENT_DESCRIPTION"] == null ? null : json["EVENT_DESCRIPTION"],
    eventDate: json["EVENT_DATE"] == null ? null : DateTime.parse(json["EVENT_DATE"]),
    eventTime: json["EVENT_TIME"] == null ? null : json["EVENT_TIME"],
    eventVenue: json["EVENT_VENUE"] == null ? null : json["EVENT_VENUE"],
    eventStatus: json["EVENT_STATUS"] == null ? null : json["EVENT_STATUS"],
    eventRemarks: json["EVENT_REMARKS"] == null ? null : json["EVENT_REMARKS"],
  );

  Map<String, dynamic> toJson() => {
    "EVENT_ID": eventId == null ? null : eventId,
    "EVENT_TITLE": eventTitle == null ? null : eventTitle,
    "EVENT_DESCRIPTION": eventDescription == null ? null : eventDescription,
    "EVENT_DATE": eventDate == null ? null : "${eventDate.year.toString().padLeft(4, '0')}-${eventDate.month.toString().padLeft(2, '0')}-${eventDate.day.toString().padLeft(2, '0')}",
    "EVENT_TIME": eventTime == null ? null : eventTime,
    "EVENT_VENUE": eventVenue == null ? null : eventVenue,
    "EVENT_STATUS": eventStatus == null ? null : eventStatus,
    "EVENT_REMARKS": eventRemarks == null ? null : eventRemarks,
  };
}
