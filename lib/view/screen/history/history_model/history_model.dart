import 'dart:convert';

class HistoryModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  HistoryModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory HistoryModel.fromRawJson(String str) => HistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
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

  Data({
    this.type,
    this.attributes,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "attributes": attributes?.toJson(),
  };
}

class Attributes {
  List<Booking>? bookings;
  Pagination? pagination;

  Attributes({
    this.bookings,
    this.pagination,
  });

  factory Attributes.fromRawJson(String str) => Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    bookings: json["bookings"] == null ? [] : List<Booking>.from(json["bookings"]!.map((x) => Booking.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "bookings": bookings == null ? [] : List<dynamic>.from(bookings!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Booking {
  String? id;
  String? bookingId;
  Id? userId;
  Id? hostId;
  ResidenceId? residenceId;
  int? numberOfGuests;
  String? userContactNumber;
  int? totalAmount;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  String? status;
  String? guestTypes;
  String? paymentTypes;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Booking({
    this.id,
    this.bookingId,
    this.userId,
    this.hostId,
    this.residenceId,
    this.numberOfGuests,
    this.userContactNumber,
    this.totalAmount,
    this.checkInTime,
    this.checkOutTime,
    this.status,
    this.guestTypes,
    this.paymentTypes,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Booking.fromRawJson(String str) => Booking.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["_id"],
    bookingId: json["bookingId"],
    userId: json["userId"] == null ? null : Id.fromJson(json["userId"]),
    hostId: json["hostId"] == null ? null : Id.fromJson(json["hostId"]),
    residenceId: json["residenceId"] == null ? null : ResidenceId.fromJson(json["residenceId"]),
    numberOfGuests: json["numberOfGuests"],
    userContactNumber: json["userContactNumber"],
    totalAmount: json["totalAmount"],
    checkInTime: json["checkInTime"] == null ? null : DateTime.parse(json["checkInTime"]),
    checkOutTime: json["checkOutTime"] == null ? null : DateTime.parse(json["checkOutTime"]),
    status: json["status"],
    guestTypes: json["guestTypes"],
    paymentTypes: json["paymentTypes"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bookingId": bookingId,
    "userId": userId?.toJson(),
    "hostId": hostId?.toJson(),
    "residenceId": residenceId?.toJson(),
    "numberOfGuests": numberOfGuests,
    "userContactNumber": userContactNumber,
    "totalAmount": totalAmount,
    "checkInTime": checkInTime?.toIso8601String(),
    "checkOutTime": checkOutTime?.toIso8601String(),
    "status": status,
    "guestTypes": guestTypes,
    "paymentTypes": paymentTypes,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Id {
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

  Id({
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

  factory Id.fromRawJson(String str) => Id.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Id.fromJson(Map<String, dynamic> json) => Id(
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
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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

class ResidenceId {
  String? id;
  String? residenceName;
  List<Image>? photo;
  int? capacity;
  dynamic beds;
  dynamic baths;
  String? address;
  String? city;
  String? municipality;
  String? quirtier;
  String? aboutResidence;
  dynamic hourlyAmount;
  int? popularity;
  int? ratings;
  dynamic dailyAmount;
  List<String>? amenities;
  String? ownerName;
  String? hostId;
  String? aboutOwner;
  String? status;
  String? category;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ResidenceId({
    this.id,
    this.residenceName,
    this.photo,
    this.capacity,
    this.beds,
    this.baths,
    this.address,
    this.city,
    this.municipality,
    this.quirtier,
    this.aboutResidence,
    this.hourlyAmount,
    this.popularity,
    this.ratings,
    this.dailyAmount,
    this.amenities,
    this.ownerName,
    this.hostId,
    this.aboutOwner,
    this.status,
    this.category,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ResidenceId.fromRawJson(String str) => ResidenceId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResidenceId.fromJson(Map<String, dynamic> json) => ResidenceId(
    id: json["_id"],
    residenceName: json["residenceName"],
    photo: json["photo"] == null ? [] : List<Image>.from(json["photo"]!.map((x) => Image.fromJson(x))),
    capacity: json["capacity"],
    beds: json["beds"],
    baths: json["baths"],
    address: json["address"],
    city: json["city"],
    municipality: json["municipality"],
    quirtier: json["quirtier"],
    aboutResidence: json["aboutResidence"],
    hourlyAmount: json["hourlyAmount"],
    popularity: json["popularity"],
    ratings: json["ratings"],
    dailyAmount: json["dailyAmount"],
    amenities: json["amenities"] == null ? [] : List<String>.from(json["amenities"]!.map((x) => x)),
    ownerName: json["ownerName"],
    hostId: json["hostId"],
    aboutOwner: json["aboutOwner"],
    status: json["status"],
    category: json["category"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "residenceName": residenceName,
    "photo": photo == null ? [] : List<dynamic>.from(photo!.map((x) => x.toJson())),
    "capacity": capacity,
    "beds": beds,
    "baths": baths,
    "address": address,
    "city": city,
    "municipality": municipality,
    "quirtier": quirtier,
    "aboutResidence": aboutResidence,
    "hourlyAmount": hourlyAmount,
    "popularity": popularity,
    "ratings": ratings,
    "dailyAmount": dailyAmount,
    "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x)),
    "ownerName": ownerName,
    "hostId": hostId,
    "aboutOwner": aboutOwner,
    "status": status,
    "category": category,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Pagination {
  int? totalDocuments;
  int? totalPage;
  int? currentPage;
  dynamic previousPage;
  dynamic nextPage;

  Pagination({
    this.totalDocuments,
    this.totalPage,
    this.currentPage,
    this.previousPage,
    this.nextPage,
  });

  factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalDocuments: json["totalDocuments"],
    totalPage: json["totalPage"],
    currentPage: json["currentPage"],
    previousPage: json["previousPage"],
    nextPage: json["nextPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalDocuments": totalDocuments,
    "totalPage": totalPage,
    "currentPage": currentPage,
    "previousPage": previousPage,
    "nextPage": nextPage,
  };
}
