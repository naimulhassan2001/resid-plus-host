// To parse this JSON data, do
//
//     final withDrawModel = withDrawModelFromJson(jsonString);

import 'dart:convert';

WithDrawModel withDrawModelFromJson(String str) => WithDrawModel.fromJson(json.decode(str));

String withDrawModelToJson(WithDrawModel data) => json.encode(data.toJson());

class WithDrawModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  WithDrawModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory WithDrawModel.fromJson(Map<String, dynamic> json) => WithDrawModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
