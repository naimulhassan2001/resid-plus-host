class IncomeModel {
  IncomeModel({
      String? data,}){
    _data = data;
}

  IncomeModel.fromJson(dynamic json) {
    _data = json['data'].toString();
  }
  String? _data;

  String? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    return map;
  }

}