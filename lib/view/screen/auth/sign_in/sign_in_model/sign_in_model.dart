import 'dart:convert';

class SignInModel {
  String? status;
  int? statusCode;
  String? message;
  Data? data;

  SignInModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory SignInModel.fromRawJson(String str) =>
      SignInModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
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
  String? type;
  Attributes? attributes;
  String? token;

  Data({
    this.type,
    this.attributes,
    this.token,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        attributes: json["attributes"] == null
            ? null
            : Attributes.fromJson(json["attributes"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "attributes": attributes?.toJson(),
        "token": token,
      };
}

class Attributes {
  String? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? address;
  String? dateOfBirth;
  String? password;
  Image? image;
  String? role;
  bool? emailVerified;
  dynamic oneTimeCode;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Attributes({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.address,
    this.dateOfBirth,
    this.password,
    this.image,
    this.role,
    this.emailVerified,
    this.oneTimeCode,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Attributes.fromRawJson(String str) =>
      Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        dateOfBirth: json["dateOfBirth"],
        password: json["password"],
        image: json["image"] == null ? null : Image.fromJson(json["image"]),
        role: json["role"],
        emailVerified: json["emailVerified"],
        oneTimeCode: json["oneTimeCode"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "address": address,
        "dateOfBirth": dateOfBirth,
        "password": password,
        "image": image?.toJson(),
        "role": role,
        "emailVerified": emailVerified,
        "oneTimeCode": oneTimeCode,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Image {
  String? publicFileUrl;
  String? path;

  Image({
    this.publicFileUrl,
    this.path,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        publicFileUrl: json["publicFileUrl"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "publicFileUrl": publicFileUrl,
        "path": path,
      };
}
