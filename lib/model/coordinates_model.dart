import 'dart:convert';

CoordinatesModel coordinatesModelFromJson(String str) => CoordinatesModel.fromJson(json.decode(str));

String coordinatesModelToJson(CoordinatesModel data) => json.encode(data.toJson());

class CoordinatesModel {
  CoordinatesModel({
    this.status,
    this.statusMessage,
    this.data,
  });

  int status;
  String statusMessage;
  Data data;

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) => CoordinatesModel(
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
    this.coordinates,
  });

  List<Coordinate> coordinates;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    coordinates: json["coordinates"] == null ? null : List<Coordinate>.from(json["coordinates"].map((x) => Coordinate.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => x.toJson())),
  };
}

class Coordinate {
  Coordinate({
    this.holeNo,
    this.teeBackLat,
    this.teeBackLong,
    this.teeFrontLat,
    this.teeFrontLong,
    this.fairwayStarLat,
    this.fairwayStarLong,
    this.greenMiddleLat,
    this.greenMiddleLongi,
    this.greenFrontLat,
    this.greenFrontLong,
    this.greenBackLat,
    this.greenBackLong,
    this.teeBackLeftLatitude,
    this.teeBackLeftLongitude,
    this.teeBackRightLatitude,
    this.teeBackRightLongitude,
    this.teeFrontLeftLatitude,
    this.teeFrontLeftLongitude,
    this.teeFrontRightLatitude,
    this.teeFrontRightLongitude,
    this.status,
  });

  String holeNo;
  String teeBackLat;
  String teeBackLong;
  String teeFrontLat;
  String teeFrontLong;
  String fairwayStarLat;
  String fairwayStarLong;
  String greenMiddleLat;
  String greenMiddleLongi;
  String greenFrontLat;
  String greenFrontLong;
  String greenBackLat;
  String greenBackLong;
  String teeBackLeftLatitude;
  String teeBackLeftLongitude;
  String teeBackRightLatitude;
  String teeBackRightLongitude;
  String teeFrontLeftLatitude;
  String teeFrontLeftLongitude;
  String teeFrontRightLatitude;
  String teeFrontRightLongitude;
  Status status;

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
    holeNo: json["hole_no"] == null ? null : json["hole_no"],
    teeBackLat: json["Tee_Back_Lat"] == null ? null : json["Tee_Back_Lat"],
    teeBackLong: json["Tee_Back_Long"] == null ? null : json["Tee_Back_Long"],
    teeFrontLat: json["Tee_Front_Lat"] == null ? null : json["Tee_Front_Lat"],
    teeFrontLong: json["Tee_Front_Long"] == null ? null : json["Tee_Front_Long"],
    fairwayStarLat: json["Fairway_Star_Lat"] == null ? null : json["Fairway_Star_Lat"],
    fairwayStarLong: json["Fairway_Star_Long"] == null ? null : json["Fairway_Star_Long"],
    greenMiddleLat: json["Green_Middle_Lat"] == null ? null : json["Green_Middle_Lat"],
    greenMiddleLongi: json["Green_Middle_Longi"] == null ? null : json["Green_Middle_Longi"],
    greenFrontLat: json["Green_Front_Lat"] == null ? null : json["Green_Front_Lat"],
    greenFrontLong: json["Green_Front_Long"] == null ? null : json["Green_Front_Long"],
    greenBackLat: json["Green_Back_Lat"] == null ? null : json["Green_Back_Lat"],
    greenBackLong: json["Green_Back_Long"] == null ? null : json["Green_Back_Long"],
    teeBackLeftLatitude: json["Tee_Back_Left_Latitude"] == null ? null : json["Tee_Back_Left_Latitude"],
    teeBackLeftLongitude: json["Tee_Back_Left_Longitude"] == null ? null : json["Tee_Back_Left_Longitude"],
    teeBackRightLatitude: json["Tee_Back_Right_Latitude"] == null ? null : json["Tee_Back_Right_Latitude"],
    teeBackRightLongitude: json["Tee_Back_Right_Longitude"] == null ? null : json["Tee_Back_Right_Longitude"],
    teeFrontLeftLatitude: json["Tee_Front_Left_Latitude"] == null ? null : json["Tee_Front_Left_Latitude"],
    teeFrontLeftLongitude: json["Tee_Front_Left_Longitude"] == null ? null : json["Tee_Front_Left_Longitude"],
    teeFrontRightLatitude: json["Tee_Front_Right_Latitude"] == null ? null : json["Tee_Front_Right_Latitude"],
    teeFrontRightLongitude: json["Tee_Front_Right_Longitude"] == null ? null : json["Tee_Front_Right_Longitude"],
    status: json["status"] == null ? null : statusValues.map[json["status"]],
  );

  Map<String, dynamic> toJson() => {
    "hole_no": holeNo == null ? null : holeNo,
    "Tee_Back_Lat": teeBackLat == null ? null : teeBackLat,
    "Tee_Back_Long": teeBackLong == null ? null : teeBackLong,
    "Tee_Front_Lat": teeFrontLat == null ? null : teeFrontLat,
    "Tee_Front_Long": teeFrontLong == null ? null : teeFrontLong,
    "Fairway_Star_Lat": fairwayStarLat == null ? null : fairwayStarLat,
    "Fairway_Star_Long": fairwayStarLong == null ? null : fairwayStarLong,
    "Green_Middle_Lat": greenMiddleLat == null ? null : greenMiddleLat,
    "Green_Middle_Longi": greenMiddleLongi == null ? null : greenMiddleLongi,
    "Green_Front_Lat": greenFrontLat == null ? null : greenFrontLat,
    "Green_Front_Long": greenFrontLong == null ? null : greenFrontLong,
    "Green_Back_Lat": greenBackLat == null ? null : greenBackLat,
    "Green_Back_Long": greenBackLong == null ? null : greenBackLong,
    "Tee_Back_Left_Latitude": teeBackLeftLatitude == null ? null : teeBackLeftLatitude,
    "Tee_Back_Left_Longitude": teeBackLeftLongitude == null ? null : teeBackLeftLongitude,
    "Tee_Back_Right_Latitude": teeBackRightLatitude == null ? null : teeBackRightLatitude,
    "Tee_Back_Right_Longitude": teeBackRightLongitude == null ? null : teeBackRightLongitude,
    "Tee_Front_Left_Latitude": teeFrontLeftLatitude == null ? null : teeFrontLeftLatitude,
    "Tee_Front_Left_Longitude": teeFrontLeftLongitude == null ? null : teeFrontLeftLongitude,
    "Tee_Front_Right_Latitude": teeFrontRightLatitude == null ? null : teeFrontRightLatitude,
    "Tee_Front_Right_Longitude": teeFrontRightLongitude == null ? null : teeFrontRightLongitude,
    "status": status == null ? null : statusValues.reverse[status],
  };
}

enum Status { ACTIVE }

final statusValues = EnumValues({
  "active": Status.ACTIVE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
