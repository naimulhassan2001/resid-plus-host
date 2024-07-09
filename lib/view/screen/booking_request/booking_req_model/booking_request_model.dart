class BookingRequestModel {
  BookingRequestModel({
      String? status, 
      String? statusCode, 
      String? message, 
      Data? data,}){
    _status = status;
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  BookingRequestModel.fromJson(dynamic json) {
    _status = json['status'];
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  String? _statusCode;
  String? _message;
  Data? _data;

  String? get status => _status;
  String? get statusCode => _statusCode;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      String? type, 
      Attributes? attributes,}){
    _type = type;
    _attributes = attributes;
}

  Data.fromJson(dynamic json) {
    _type = json['type'];
    _attributes = json['attributes'] != null ? Attributes.fromJson(json['attributes']) : null;
  }
  String? _type;
  Attributes? _attributes;

  String? get type => _type;
  Attributes? get attributes => _attributes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    if (_attributes != null) {
      map['attributes'] = _attributes?.toJson();
    }
    return map;
  }

}

class Attributes {
  Attributes({
      List<Bookings>? bookings, 
      Pagination? pagination,}){
    _bookings = bookings;
    _pagination = pagination;
}

  Attributes.fromJson(dynamic json) {
    if (json['bookings'] != null) {
      _bookings = [];
      json['bookings'].forEach((v) {
        _bookings?.add(Bookings.fromJson(v));
      });
    }
    _pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Bookings>? _bookings;
  Pagination? _pagination;

  List<Bookings>? get bookings => _bookings;
  Pagination? get pagination => _pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_bookings != null) {
      map['bookings'] = _bookings?.map((v) => v.toJson()).toList();
    }
    if (_pagination != null) {
      map['pagination'] = _pagination?.toJson();
    }
    return map;
  }

}

class Pagination {
  Pagination({
      int? totalDocuments, 
      int? totalPage, 
      int? currentPage, 
      dynamic previousPage, 
      dynamic nextPage,}){
    _totalDocuments = totalDocuments;
    _totalPage = totalPage;
    _currentPage = currentPage;
    _previousPage = previousPage;
    _nextPage = nextPage;
}

  Pagination.fromJson(dynamic json) {
    _totalDocuments = json['totalDocuments'];
    _totalPage = json['totalPage'];
    _currentPage = json['currentPage'];
    _previousPage = json['previousPage'];
    _nextPage = json['nextPage'];
  }
  int? _totalDocuments;
  int? _totalPage;
  int? _currentPage;
  dynamic _previousPage;
  dynamic _nextPage;

  int? get totalDocuments => _totalDocuments;
  int? get totalPage => _totalPage;
  int? get currentPage => _currentPage;
  dynamic get previousPage => _previousPage;
  dynamic get nextPage => _nextPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalDocuments'] = _totalDocuments;
    map['totalPage'] = _totalPage;
    map['currentPage'] = _currentPage;
    map['previousPage'] = _previousPage;
    map['nextPage'] = _nextPage;
    return map;
  }

}

class Bookings {
  Bookings({
      TotalTime? totalTime, 
      String? id, 
      String? bookingId, 
      UserId? userId, 
      HostId? hostId, 
      ResidenceId? residenceId, 
      int? numberOfGuests, 
      String? userContactNumber, 
      int? totalAmount, 
      String? checkInTime, 
      String? checkOutTime, 
      String? status, 
      String? guestTypes, 
      String? paymentTypes, 
      bool? isDeleted, 
      bool? isUserHistoryDeleted, 
      bool? isHostHistoryDeleted, 
      String? createdAt, 
      String? updatedAt, 
      int? v,}){
    _totalTime = totalTime;
    _id = id;
    _bookingId = bookingId;
    _userId = userId;
    _hostId = hostId;
    _residenceId = residenceId;
    _numberOfGuests = numberOfGuests;
    _userContactNumber = userContactNumber;
    _totalAmount = totalAmount;
    _checkInTime = checkInTime;
    _checkOutTime = checkOutTime;
    _status = status;
    _guestTypes = guestTypes;
    _paymentTypes = paymentTypes;
    _isDeleted = isDeleted;
    _isUserHistoryDeleted = isUserHistoryDeleted;
    _isHostHistoryDeleted = isHostHistoryDeleted;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Bookings.fromJson(dynamic json) {
    _totalTime = json['totalTime'] != null ? TotalTime.fromJson(json['totalTime']) : null;
    _id = json['_id'];
    _bookingId = json['bookingId'];
    _userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    _hostId = json['hostId'] != null ? HostId.fromJson(json['hostId']) : null;
    _residenceId = json['residenceId'] != null ? ResidenceId.fromJson(json['residenceId']) : null;
    _numberOfGuests = json['numberOfGuests'];
    _userContactNumber = json['userContactNumber'];
    _totalAmount = json['totalAmount'];
    _checkInTime = json['checkInTime'];
    _checkOutTime = json['checkOutTime'];
    _status = json['status'];
    _guestTypes = json['guestTypes'];
    _paymentTypes = json['paymentTypes'];
    _isDeleted = json['isDeleted'];
    _isUserHistoryDeleted = json['isUserHistoryDeleted'];
    _isHostHistoryDeleted = json['isHostHistoryDeleted'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  TotalTime? _totalTime;
  String? _id;
  String? _bookingId;
  UserId? _userId;
  HostId? _hostId;
  ResidenceId? _residenceId;
  int? _numberOfGuests;
  String? _userContactNumber;
  int? _totalAmount;
  String? _checkInTime;
  String? _checkOutTime;
  String? _status;
  String? _guestTypes;
  String? _paymentTypes;
  bool? _isDeleted;
  bool? _isUserHistoryDeleted;
  bool? _isHostHistoryDeleted;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  TotalTime? get totalTime => _totalTime;
  String? get id => _id;
  String? get bookingId => _bookingId;
  UserId? get userId => _userId;
  HostId? get hostId => _hostId;
  ResidenceId? get residenceId => _residenceId;
  int? get numberOfGuests => _numberOfGuests;
  String? get userContactNumber => _userContactNumber;
  int? get totalAmount => _totalAmount;
  String? get checkInTime => _checkInTime;
  String? get checkOutTime => _checkOutTime;
  String? get status => _status;
  String? get guestTypes => _guestTypes;
  String? get paymentTypes => _paymentTypes;
  bool? get isDeleted => _isDeleted;
  bool? get isUserHistoryDeleted => _isUserHistoryDeleted;
  bool? get isHostHistoryDeleted => _isHostHistoryDeleted;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_totalTime != null) {
      map['totalTime'] = _totalTime?.toJson();
    }
    map['_id'] = _id;
    map['bookingId'] = _bookingId;
    if (_userId != null) {
      map['userId'] = _userId?.toJson();
    }
    if (_hostId != null) {
      map['hostId'] = _hostId?.toJson();
    }
    if (_residenceId != null) {
      map['residenceId'] = _residenceId?.toJson();
    }
    map['numberOfGuests'] = _numberOfGuests;
    map['userContactNumber'] = _userContactNumber;
    map['totalAmount'] = _totalAmount;
    map['checkInTime'] = _checkInTime;
    map['checkOutTime'] = _checkOutTime;
    map['status'] = _status;
    map['guestTypes'] = _guestTypes;
    map['paymentTypes'] = _paymentTypes;
    map['isDeleted'] = _isDeleted;
    map['isUserHistoryDeleted'] = _isUserHistoryDeleted;
    map['isHostHistoryDeleted'] = _isHostHistoryDeleted;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

class ResidenceId {
  ResidenceId({
      String? id, 
      String? residenceName, 
      List<Photo>? photo, 
      int? capacity, 
      int? beds, 
      int? baths, 
      String? address, 
      String? city, 
      String? municipality, 
      String? quirtier, 
      String? aboutResidence, 
      int? hourlyAmount, 
      int? popularity, 
      int? ratings, 
      int? dailyAmount, 
      List<String>? amenities, 
      String? ownerName, 
      String? hostId, 
      String? aboutOwner, 
      String? status, 
      String? category, 
      bool? isDeleted, 
      String? createdAt, 
      String? updatedAt, 
      int? v,}){
    _id = id;
    _residenceName = residenceName;
    _photo = photo;
    _capacity = capacity;
    _beds = beds;
    _baths = baths;
    _address = address;
    _city = city;
    _municipality = municipality;
    _quirtier = quirtier;
    _aboutResidence = aboutResidence;
    _hourlyAmount = hourlyAmount;
    _popularity = popularity;
    _ratings = ratings;
    _dailyAmount = dailyAmount;
    _amenities = amenities;
    _ownerName = ownerName;
    _hostId = hostId;
    _aboutOwner = aboutOwner;
    _status = status;
    _category = category;
    _isDeleted = isDeleted;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  ResidenceId.fromJson(dynamic json) {
    _id = json['_id'];
    _residenceName = json['residenceName'];
    if (json['photo'] != null) {
      _photo = [];
      json['photo'].forEach((v) {
        _photo?.add(Photo.fromJson(v));
      });
    }
    _capacity = json['capacity'];
    _beds = json['beds'];
    _baths = json['baths'];
    _address = json['address'];
    _city = json['city'];
    _municipality = json['municipality'];
    _quirtier = json['quirtier'];
    _aboutResidence = json['aboutResidence'];
    _hourlyAmount = json['hourlyAmount'];
    _popularity = json['popularity'];
    _ratings = json['ratings'];
    _dailyAmount = json['dailyAmount'];
    _amenities = json['amenities'] != null ? json['amenities'].cast<String>() : [];
    _ownerName = json['ownerName'];
    _hostId = json['hostId'];
    _aboutOwner = json['aboutOwner'];
    _status = json['status'];
    _category = json['category'];
    _isDeleted = json['isDeleted'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _residenceName;
  List<Photo>? _photo;
  int? _capacity;
  int? _beds;
  int? _baths;
  String? _address;
  String? _city;
  String? _municipality;
  String? _quirtier;
  String? _aboutResidence;
  int? _hourlyAmount;
  int? _popularity;
  int? _ratings;
  int? _dailyAmount;
  List<String>? _amenities;
  String? _ownerName;
  String? _hostId;
  String? _aboutOwner;
  String? _status;
  String? _category;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  String? get id => _id;
  String? get residenceName => _residenceName;
  List<Photo>? get photo => _photo;
  int? get capacity => _capacity;
  int? get beds => _beds;
  int? get baths => _baths;
  String? get address => _address;
  String? get city => _city;
  String? get municipality => _municipality;
  String? get quirtier => _quirtier;
  String? get aboutResidence => _aboutResidence;
  int? get hourlyAmount => _hourlyAmount;
  int? get popularity => _popularity;
  int? get ratings => _ratings;
  int? get dailyAmount => _dailyAmount;
  List<String>? get amenities => _amenities;
  String? get ownerName => _ownerName;
  String? get hostId => _hostId;
  String? get aboutOwner => _aboutOwner;
  String? get status => _status;
  String? get category => _category;
  bool? get isDeleted => _isDeleted;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['residenceName'] = _residenceName;
    if (_photo != null) {
      map['photo'] = _photo?.map((v) => v.toJson()).toList();
    }
    map['capacity'] = _capacity;
    map['beds'] = _beds;
    map['baths'] = _baths;
    map['address'] = _address;
    map['city'] = _city;
    map['municipality'] = _municipality;
    map['quirtier'] = _quirtier;
    map['aboutResidence'] = _aboutResidence;
    map['hourlyAmount'] = _hourlyAmount;
    map['popularity'] = _popularity;
    map['ratings'] = _ratings;
    map['dailyAmount'] = _dailyAmount;
    map['amenities'] = _amenities;
    map['ownerName'] = _ownerName;
    map['hostId'] = _hostId;
    map['aboutOwner'] = _aboutOwner;
    map['status'] = _status;
    map['category'] = _category;
    map['isDeleted'] = _isDeleted;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

class Photo {
  Photo({
      String? publicFileUrl, 
      String? path,}){
    _publicFileUrl = publicFileUrl;
    _path = path;
}

  Photo.fromJson(dynamic json) {
    _publicFileUrl = json['publicFileUrl'];
    _path = json['path'];
  }
  String? _publicFileUrl;
  String? _path;

  String? get publicFileUrl => _publicFileUrl;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['publicFileUrl'] = _publicFileUrl;
    map['path'] = _path;
    return map;
  }

}

class HostId {
  HostId({
      String? id, 
      String? fullName, 
      String? email, 
      String? phoneNumber, 
      String? address, 
      String? dateOfBirth, 
      String? password, 
      Image? image, 
      String? role, 
      bool? emailVerified, 
      dynamic oneTimeCode, 
      bool? isDeleted, 
      String? createdAt, 
      String? updatedAt, 
      int? v, 
      String? status,}){
    _id = id;
    _fullName = fullName;
    _email = email;
    _phoneNumber = phoneNumber;
    _address = address;
    _dateOfBirth = dateOfBirth;
    _password = password;
    _image = image;
    _role = role;
    _emailVerified = emailVerified;
    _oneTimeCode = oneTimeCode;
    _isDeleted = isDeleted;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _status = status;
}

  HostId.fromJson(dynamic json) {
    _id = json['_id'];
    _fullName = json['fullName'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _address = json['address'];
    _dateOfBirth = json['dateOfBirth'];
    _password = json['password'];
    _image = json['image'] != null ? Image.fromJson(json['image']) : null;
    _role = json['role'];
    _emailVerified = json['emailVerified'];
    _oneTimeCode = json['oneTimeCode'];
    _isDeleted = json['isDeleted'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _status = json['status'];
  }
  String? _id;
  String? _fullName;
  String? _email;
  String? _phoneNumber;
  String? _address;
  String? _dateOfBirth;
  String? _password;
  Image? _image;
  String? _role;
  bool? _emailVerified;
  dynamic _oneTimeCode;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  int? _v;
  String? _status;

  String? get id => _id;
  String? get fullName => _fullName;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get address => _address;
  String? get dateOfBirth => _dateOfBirth;
  String? get password => _password;
  Image? get image => _image;
  String? get role => _role;
  bool? get emailVerified => _emailVerified;
  dynamic get oneTimeCode => _oneTimeCode;
  bool? get isDeleted => _isDeleted;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['fullName'] = _fullName;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['address'] = _address;
    map['dateOfBirth'] = _dateOfBirth;
    map['password'] = _password;
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    map['role'] = _role;
    map['emailVerified'] = _emailVerified;
    map['oneTimeCode'] = _oneTimeCode;
    map['isDeleted'] = _isDeleted;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['status'] = _status;
    return map;
  }

}

class Image {
  Image({
      String? publicFileUrl, 
      String? path,}){
    _publicFileUrl = publicFileUrl;
    _path = path;
}

  Image.fromJson(dynamic json) {
    _publicFileUrl = json['publicFileUrl'];
    _path = json['path'];
  }
  String? _publicFileUrl;
  String? _path;

  String? get publicFileUrl => _publicFileUrl;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['publicFileUrl'] = _publicFileUrl;
    map['path'] = _path;
    return map;
  }

}

class UserId {
  UserId({
      String? id, 
      String? fullName, 
      String? email, 
      String? phoneNumber, 
      String? address, 
      String? dateOfBirth, 
      String? password, 
      Image? image, 
      String? role, 
      bool? emailVerified, 
      dynamic oneTimeCode, 
      bool? isDeleted, 
      String? createdAt, 
      String? updatedAt, 
      int? v, 
      String? status,}){
    _id = id;
    _fullName = fullName;
    _email = email;
    _phoneNumber = phoneNumber;
    _address = address;
    _dateOfBirth = dateOfBirth;
    _password = password;
    _image = image;
    _role = role;
    _emailVerified = emailVerified;
    _oneTimeCode = oneTimeCode;
    _isDeleted = isDeleted;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _status = status;
}

  UserId.fromJson(dynamic json) {
    _id = json['_id'];
    _fullName = json['fullName'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _address = json['address'];
    _dateOfBirth = json['dateOfBirth'];
    _password = json['password'];
    _image = json['image'] != null ? Image.fromJson(json['image']) : null;
    _role = json['role'];
    _emailVerified = json['emailVerified'];
    _oneTimeCode = json['oneTimeCode'];
    _isDeleted = json['isDeleted'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _status = json['status'];
  }
  String? _id;
  String? _fullName;
  String? _email;
  String? _phoneNumber;
  String? _address;
  String? _dateOfBirth;
  String? _password;
  Image? _image;
  String? _role;
  bool? _emailVerified;
  dynamic _oneTimeCode;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  int? _v;
  String? _status;

  String? get id => _id;
  String? get fullName => _fullName;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get address => _address;
  String? get dateOfBirth => _dateOfBirth;
  String? get password => _password;
  Image? get image => _image;
  String? get role => _role;
  bool? get emailVerified => _emailVerified;
  dynamic get oneTimeCode => _oneTimeCode;
  bool? get isDeleted => _isDeleted;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['fullName'] = _fullName;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['address'] = _address;
    map['dateOfBirth'] = _dateOfBirth;
    map['password'] = _password;
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    map['role'] = _role;
    map['emailVerified'] = _emailVerified;
    map['oneTimeCode'] = _oneTimeCode;
    map['isDeleted'] = _isDeleted;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['status'] = _status;
    return map;
  }

}

class TotalTime {
  TotalTime({
      String? days,
      String? hours,}){
    _days = days;
    _hours = hours;
}

  TotalTime.fromJson(dynamic json) {
    _days = json['days'].toString();
    _hours = json['hours'].toString();
  }
  String? _days;
  String? _hours;

  String? get days => _days;
  String? get hours => _hours;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['days'] = _days;
    map['hours'] = _hours;
    return map;
  }

}