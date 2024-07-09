import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/service/api_service.dart';

class WithdrawRepo {
  ApiService apiService;
  WithdrawRepo({required this.apiService});

  Future<ApiResponseModel> withdrawData({required String accountNo, required String amount,required String withDrawMode}) async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.withdrawEndPoint}";
    String requestMethod = ApiResponseMethod.postMethod;
    Map<String, dynamic> params = {
      "account_alias": accountNo,
      "amount": int.parse(amount),
      "withdraw_mode": withDrawMode,
    };
    debugPrint("================>Body :  $params");
    debugPrint("================>ZUri :  $uri");

    ApiResponseModel responseModel = await apiService.request(uri, requestMethod ,params,body:json.encode(params), passHeader: true);
    return responseModel;
  }
}
