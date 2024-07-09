import 'dart:convert';

DailyIncomeModel dailyIncomeModelFromJson(String str) => DailyIncomeModel.fromJson(json.decode(str));

String dailyIncomeModelToJson(DailyIncomeModel data) => json.encode(data.toJson());

class DailyIncomeModel {
  Data? data;

  DailyIncomeModel({
    this.data,
  });

  factory DailyIncomeModel.fromJson(Map<String, dynamic> json) => DailyIncomeModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  List<AllPayment>? allPayments;
  int? total;

  Data({
    this.allPayments,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    allPayments: json["allPayments"] == null ? [] : List<AllPayment>.from(json["allPayments"]!.map((x) => AllPayment.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "allPayments": allPayments == null ? [] : List<dynamic>.from(allPayments!.map((x) => x.toJson())),
    "total": total,
  };
}

class AllPayment {
  String? id;
  PaymentData? paymentData;
  BookingId? bookingId;
  ResidenceId? residenceId;
  String? userId;
  String? hostId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  AllPayment({
    this.id,
    this.paymentData,
    this.bookingId,
    this.residenceId,
    this.userId,
    this.hostId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AllPayment.fromJson(Map<String, dynamic> json) => AllPayment(
    id: json["_id"],
    paymentData: json["paymentData"] == null ? null : PaymentData.fromJson(json["paymentData"]),
    bookingId: json["bookingId"] == null ? null : BookingId.fromJson(json["bookingId"]),
    residenceId: json["residenceId"] == null ? null : ResidenceId.fromJson(json["residenceId"]),
    userId: json["userId"],
    hostId: json["hostId"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "paymentData": paymentData?.toJson(),
    "bookingId": bookingId?.toJson(),
    "residenceId": residenceId?.toJson(),
    "userId": userId,
    "hostId": hostId,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class BookingId {
  String? id;
  String? bookingId;
  String? userId;
  String? hostId;
  String? residenceId;
  int? numberOfGuests;
  String? userContactNumber;
  int? totalAmount;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  String? status;
  String? guestTypes;
  String? paymentTypes;
  bool? isDeleted;
  bool? isUserHistoryDeleted;
  bool? isHostHistoryDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? totalHours;

  BookingId({
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
    this.isUserHistoryDeleted,
    this.isHostHistoryDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.totalHours,
  });

  factory BookingId.fromJson(Map<String, dynamic> json) => BookingId(
    id: json["_id"],
    bookingId: json["bookingId"],
    userId: json["userId"],
    hostId: json["hostId"],
    residenceId: json["residenceId"],
    numberOfGuests: json["numberOfGuests"],
    userContactNumber: json["userContactNumber"],
    totalAmount: json["totalAmount"],
    checkInTime: json["checkInTime"] == null ? null : DateTime.parse(json["checkInTime"]),
    checkOutTime: json["checkOutTime"] == null ? null : DateTime.parse(json["checkOutTime"]),
    status: json["status"],
    guestTypes: json["guestTypes"],
    paymentTypes: json["paymentTypes"],
    isDeleted: json["isDeleted"],
    isUserHistoryDeleted: json["isUserHistoryDeleted"],
    isHostHistoryDeleted: json["isHostHistoryDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    totalHours: json["totalHours"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bookingId": bookingId,
    "userId": userId,
    "hostId": hostId,
    "residenceId": residenceId,
    "numberOfGuests": numberOfGuests,
    "userContactNumber": userContactNumber,
    "totalAmount": totalAmount,
    "checkInTime": checkInTime?.toIso8601String(),
    "checkOutTime": checkOutTime?.toIso8601String(),
    "status": status,
    "guestTypes": guestTypes,
    "paymentTypes": paymentTypes,
    "isDeleted": isDeleted,
    "isUserHistoryDeleted": isUserHistoryDeleted,
    "isHostHistoryDeleted": isHostHistoryDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "totalHours": totalHours,
  };
}

class PaymentData {
  RequestData? requestData;
  String? transactionId;
  String? status;

  PaymentData({
    this.requestData,
    this.transactionId,
    this.status,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
    requestData: json["requestData"] == null ? null : RequestData.fromJson(json["requestData"]),
    transactionId: json["transactionId"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "requestData": requestData?.toJson(),
    "transactionId": transactionId,
    "status": status,
  };
}

class RequestData {
  dynamic countries;
  dynamic partnerId;
  int? amount;
  String? reason;
  String? phone;
  String? data;
  dynamic paymentMethods;
  bool? sandbox;
  String? name;
  String? email;

  RequestData({
    this.countries,
    this.partnerId,
    this.amount,
    this.reason,
    this.phone,
    this.data,
    this.paymentMethods,
    this.sandbox,
    this.name,
    this.email,
  });

  factory RequestData.fromJson(Map<String, dynamic> json) => RequestData(
    countries: json["countries"],
    partnerId: json["partnerId"],
    amount: json["amount"],
    reason: json["reason"],
    phone: json["phone"],
    data: json["data"],
    paymentMethods: json["paymentMethods"],
    sandbox: json["sandbox"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "countries": countries,
    "partnerId": partnerId,
    "amount": amount,
    "reason": reason,
    "phone": phone,
    "data": data,
    "paymentMethods": paymentMethods,
    "sandbox": sandbox,
    "name": name,
    "email": email,
  };
}

class ResidenceId {
  String? id;
  String? residenceName;
  List<Photo>? photo;
  int? capacity;
  int? beds;
  int? baths;
  String? address;
  String? city;
  String? municipality;
  String? quirtier;
  String? aboutResidence;
  int? hourlyAmount;
  int? popularity;
  int? ratings;
  int? dailyAmount;
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

  factory ResidenceId.fromJson(Map<String, dynamic> json) => ResidenceId(
    id: json["_id"],
    residenceName: json["residenceName"],
    photo: json["photo"] == null ? [] : List<Photo>.from(json["photo"]!.map((x) => Photo.fromJson(x))),
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

class Photo {
  String? publicFileUrl;
  String? path;

  Photo({
    this.publicFileUrl,
    this.path,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    publicFileUrl: json["publicFileUrl"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileUrl": publicFileUrl,
    "path": path,
  };
}
