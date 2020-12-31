import 'dart:convert';

ButtonInfoModel buttonInfoModelFromJson(String str) => ButtonInfoModel.fromJson(json.decode(str));

String buttonInfoModelToJson(ButtonInfoModel data) => json.encode(data.toJson());

class ButtonInfoModel {
  ButtonInfoModel({
    this.status,
    this.statusMessage,
    this.data,
  });

  int status;
  String statusMessage;
  Data data;

  factory ButtonInfoModel.fromJson(Map<String, dynamic> json) => ButtonInfoModel(
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
    this.id,
    this.buttonText,
    this.status,
    this.menus,
  });

  String id;
  String buttonText;
  String status;
  List<Menu> menus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    buttonText: json["button_text"] == null ? null : json["button_text"],
    status: json["status"] == null ? null : json["status"],
    menus: json["menus"] == null ? null : List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "button_text": buttonText == null ? null : buttonText,
    "status": status == null ? null : status,
    "menus": menus == null ? null : List<dynamic>.from(menus.map((x) => x.toJson())),
  };
}

class Menu {
  Menu({
    this.menuText,
    this.link,
    this.icon,
  });

  String menuText;
  String link;
  String icon;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    menuText: json["menu_text"] == null ? null : json["menu_text"],
    link: json["link"] == null ? null : json["link"],
    icon: json["icon"] == null ? null : json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "menu_text": menuText == null ? null : menuText,
    "link": link == null ? null : link,
    "icon": icon == null ? null : icon,
  };
}
