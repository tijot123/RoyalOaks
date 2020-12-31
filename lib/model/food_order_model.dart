import 'dart:convert';

OrderFoodModel orderFoodModelFromJson(String str) => OrderFoodModel.fromJson(json.decode(str));

String orderFoodModelToJson(OrderFoodModel data) => json.encode(data.toJson());

class OrderFoodModel {
  OrderFoodModel({
    this.status,
    this.statusMessage,
    this.data,
  });

  int status;
  String statusMessage;
  Data data;

  factory OrderFoodModel.fromJson(Map<String, dynamic> json) => OrderFoodModel(
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
    this.golfFoodUrl,
  });

  String golfFoodUrl;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    golfFoodUrl: json["GOLF_FOOD_URL"] == null ? null : json["GOLF_FOOD_URL"],
  );

  Map<String, dynamic> toJson() => {
    "GOLF_FOOD_URL": golfFoodUrl == null ? null : golfFoodUrl,
  };
}
