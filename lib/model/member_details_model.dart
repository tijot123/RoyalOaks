import 'dart:convert';

MemberDetailsModel memberDetailsModelFromJson(String str) => MemberDetailsModel.fromJson(json.decode(str));

String memberDetailsModelToJson(MemberDetailsModel data) => json.encode(data.toJson());

class MemberDetailsModel {
  MemberDetailsModel({
    this.status,
    this.statusMessage,
    this.data,
  });

  int status;
  String statusMessage;
  Data data;

  factory MemberDetailsModel.fromJson(Map<String, dynamic> json) => MemberDetailsModel(
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
    this.dataUserId,
    this.username,
    this.email,
    this.displayName,
    this.status,
    this.password,
    this.deviceToken,
    this.deviceType,
    this.firstName,
    this.middleName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.sinceDate,
    this.homePhone,
    this.businessPhone,
    this.cellPhone,
    this.secondaryEmail,
    this.ghinNo,
    this.handicapService,
    this.profilePhoto,
    this.memberType,
    this.phoneNoStatus,
    this.addressId,
    this.userId,
    this.addressType,
    this.address1,
    this.address2,
    this.address3,
    this.city,
    this.state,
    this.zipCode,
    this.county,
    this.phoneOfAddress,
    this.createDate,
    this.countryName,
    this.addTypeName,
    this.fullAddress,
  });

  String dataUserId;
  String username;
  String email;
  String displayName;
  String status;
  String password;
  String deviceToken;
  String deviceType;
  String firstName;
  String middleName;
  String lastName;
  String gender;
  String dateOfBirth;
  DateTime sinceDate;
  String homePhone;
  String businessPhone;
  String cellPhone;
  String secondaryEmail;
  String ghinNo;
  String handicapService;
  String profilePhoto;
  String memberType;
  String phoneNoStatus;
  String addressId;
  String userId;
  String addressType;
  String address1;
  String address2;
  String address3;
  String city;
  String state;
  String zipCode;
  String county;
  String phoneOfAddress;
  DateTime createDate;
  String countryName;
  String addTypeName;
  String fullAddress;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    dataUserId: json["user_id"] == null ? null : json["user_id"],
    username: json["username"] == null ? null : json["username"],
    email: json["email"] == null ? null : json["email"],
    displayName: json["display_name"] == null ? null : json["display_name"],
    status: json["status"] == null ? null : json["status"],
    password: json["password"] == null ? null : json["password"],
    deviceToken: json["device_token"] == null ? null : json["device_token"],
    deviceType: json["device_type"] == null ? null : json["device_type"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    middleName: json["middleName"] == null ? null : json["middleName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    gender: json["gender"] == null ? null : json["gender"],
    dateOfBirth: json["dateOfBirth"] == null ? null : json["dateOfBirth"],
    sinceDate: json["sinceDate"] == null ? null : DateTime.parse(json["sinceDate"]),
    homePhone: json["homePhone"] == null ? null : json["homePhone"],
    businessPhone: json["businessPhone"] == null ? null : json["businessPhone"],
    cellPhone: json["cellPhone"] == null ? null : json["cellPhone"],
    secondaryEmail: json["secondaryEmail"] == null ? null : json["secondaryEmail"],
    ghinNo: json["GHIN_No"] == null ? null : json["GHIN_No"],
    handicapService: json["handicapService"] == null ? null : json["handicapService"],
    profilePhoto: json["profilePhoto"] == null ? null : json["profilePhoto"],
    memberType: json["memberType"] == null ? null : json["memberType"],
    phoneNoStatus: json["phoneNoStatus"] == null ? null : json["phoneNoStatus"],
    addressId: json["addressId"] == null ? null : json["addressId"],
    userId: json["userId"] == null ? null : json["userId"],
    addressType: json["addressType"] == null ? null : json["addressType"],
    address1: json["address1"] == null ? null : json["address1"],
    address2: json["address2"] == null ? null : json["address2"],
    address3: json["address3"] == null ? null : json["address3"],
    city: json["city"] == null ? null : json["city"],
    state: json["state"] == null ? null : json["state"],
    zipCode: json["zipCode"] == null ? null : json["zipCode"],
    county: json["county"] == null ? null : json["county"],
    phoneOfAddress: json["phoneOfAddress"] == null ? null : json["phoneOfAddress"],
    createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
    countryName: json["countryName"] == null ? null : json["countryName"],
    addTypeName: json["addTypeName"] == null ? null : json["addTypeName"],
    fullAddress: json["full_address"] == null ? null : json["full_address"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": dataUserId == null ? null : dataUserId,
    "username": username == null ? null : username,
    "email": email == null ? null : email,
    "display_name": displayName == null ? null : displayName,
    "status": status == null ? null : status,
    "password": password == null ? null : password,
    "device_token": deviceToken == null ? null : deviceToken,
    "device_type": deviceType == null ? null : deviceType,
    "firstName": firstName == null ? null : firstName,
    "middleName": middleName == null ? null : middleName,
    "lastName": lastName == null ? null : lastName,
    "gender": gender == null ? null : gender,
    "dateOfBirth": dateOfBirth == null ? null : dateOfBirth,
    "sinceDate": sinceDate == null ? null : "${sinceDate.year.toString().padLeft(4, '0')}-${sinceDate.month.toString().padLeft(2, '0')}-${sinceDate.day.toString().padLeft(2, '0')}",
    "homePhone": homePhone == null ? null : homePhone,
    "businessPhone": businessPhone == null ? null : businessPhone,
    "cellPhone": cellPhone == null ? null : cellPhone,
    "secondaryEmail": secondaryEmail == null ? null : secondaryEmail,
    "GHIN_No": ghinNo == null ? null : ghinNo,
    "handicapService": handicapService == null ? null : handicapService,
    "profilePhoto": profilePhoto == null ? null : profilePhoto,
    "memberType": memberType == null ? null : memberType,
    "phoneNoStatus": phoneNoStatus == null ? null : phoneNoStatus,
    "addressId": addressId == null ? null : addressId,
    "userId": userId == null ? null : userId,
    "addressType": addressType == null ? null : addressType,
    "address1": address1 == null ? null : address1,
    "address2": address2 == null ? null : address2,
    "address3": address3 == null ? null : address3,
    "city": city == null ? null : city,
    "state": state == null ? null : state,
    "zipCode": zipCode == null ? null : zipCode,
    "county": county == null ? null : county,
    "phoneOfAddress": phoneOfAddress == null ? null : phoneOfAddress,
    "createDate": createDate == null ? null : createDate.toIso8601String(),
    "countryName": countryName == null ? null : countryName,
    "addTypeName": addTypeName == null ? null : addTypeName,
    "full_address": fullAddress == null ? null : fullAddress,
  };
}
