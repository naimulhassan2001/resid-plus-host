

import 'dart:convert';

import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/service/api_service.dart';

class DeleteAccountRepo {
  ApiService apiService;

  DeleteAccountRepo({required this.apiService});

  Future<ApiResponseModel> deleteAccount({required String password}) async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.deleteAccount}";
    String requestMethod = ApiResponseMethod.deleteMethod;
    Map<String, dynamic> params = {
      "password": password,
    };

    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, json.encode(params), passHeader: true);

    return responseModel;
  }
}
