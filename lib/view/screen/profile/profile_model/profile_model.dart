class ProfileModel {
  ProfileModel({
      String? status, 
      String? statusCode, 
      String? message, 
      Data? data,}){
    _status = status;
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  ProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _statusCode = json['statusCode'].toString();
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
      User? user,}){
    _user = user;
}

  Attributes.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  User? _user;

  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      String? id, 
      String? fullName, 
      String? email, 
      String? phoneNumber, 
      String? address, 
      String? dateOfBirth, 
      Image? image,}){
    _id = id;
    _fullName = fullName;
    _email = email;
    _phoneNumber = phoneNumber;
    _address = address;
    _dateOfBirth = dateOfBirth;
    _image = image;
}

  User.fromJson(dynamic json) {
    _id = json['_id'].toString();
    _fullName = json['fullName'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'].toString();
    _address = json['address'].toString();
    _dateOfBirth = json['dateOfBirth'].toString();
    _image = json['image'] != null ? Image.fromJson(json['image']) : null;
  }
  String? _id;
  String? _fullName;
  String? _email;
  String? _phoneNumber;
  String? _address;
  String? _dateOfBirth;
  Image? _image;

  String? get id => _id;
  String? get fullName => _fullName;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get address => _address;
  String? get dateOfBirth => _dateOfBirth;
  Image? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['fullName'] = _fullName;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['address'] = _address;
    map['dateOfBirth'] = _dateOfBirth;
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
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