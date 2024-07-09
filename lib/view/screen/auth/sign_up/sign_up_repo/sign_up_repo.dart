import 'package:flutter/widgets.dart';
import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/service/api_service.dart';

class SignUpRepo {
  ApiService apiService;
  SignUpRepo({required this.apiService});

  Future<ApiResponseModel> createUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String address,
    required String dateOfBirth,
    required String countryId,
    required String password,}) async {
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.signUp}";
    print("=============$url");
    String responseMethod = ApiResponseMethod.postMethod;
    Map<String, dynamic> params = {
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "address": address,
      "dateOfBirth": dateOfBirth,
      "country": countryId,
      "password": password,
      "role": "host"
    };
  print("===============$params");
    ApiResponseModel responseModel = await apiService.request(url, responseMethod, params, passHeader: false);

    return responseModel;
  }


  //country code get

  responseCountry() async{
     String uri ="${ApiUrlContainer.baseUrl}${ApiUrlContainer.countryEndpoint}";
     String requestMethod =  ApiResponseMethod.getMethod;
     ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
     debugPrint("========URI $uri");
     return responseModel;
  }
}
