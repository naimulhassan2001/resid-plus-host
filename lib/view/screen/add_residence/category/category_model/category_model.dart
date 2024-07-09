class CategoryModel {
  CategoryModel({
      String? status, 
      String? statusCode, 
      String? message, 
      Data? data,}){
    _status = status;
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  CategoryModel.fromJson(dynamic json) {
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
      List<Attributes>? attributes,}){
    _type = type;
    _attributes = attributes;
}

  Data.fromJson(dynamic json) {
    _type = json['type'];
    if (json['attributes'] != null) {
      _attributes = [];
      json['attributes'].forEach((v) {
        _attributes?.add(Attributes.fromJson(v));
      });
    }
  }
  String? _type;
  List<Attributes>? _attributes;

  String? get type => _type;
  List<Attributes>? get attributes => _attributes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    if (_attributes != null) {
      map['attributes'] = _attributes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Attributes {
  Attributes({
      Translation? translation, 
      String? id,}){
    _translation = translation;
    _id = id;
}

  Attributes.fromJson(dynamic json) {
    _translation = json['translation'] != null ? Translation.fromJson(json['translation']) : null;
    _id = json['_id'];
  }
  Translation? _translation;
  String? _id;

  Translation? get translation => _translation;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    map['_id'] = _id;
    return map;
  }

}

class Translation {
  Translation({
      String? en, 
      String? fr,}){
    _en = en;
    _fr = fr;
}

  Translation.fromJson(dynamic json) {
    _en = json['en'];
    _fr = json['fr'];
  }
  String? _en;
  String? _fr;

  String? get en => _en;
  String? get fr => _fr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['en'] = _en;
    map['fr'] = _fr;
    return map;
  }

}