import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resid_plus/core/global/api_authorization_response_model.dart';
import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/helper/shear_preference_helper.dart';
import 'package:resid_plus/core/route/app_route.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ApiService extends GetxService {
  SharedPreferences sharedPreferences;
  ApiService({required this.sharedPreferences});

  Future<ApiResponseModel> request(String uri, String method, dynamic params, {bool passHeader = false,String? body,}) async {
    Uri url = Uri.parse(uri);
    http.Response response;

    try {
      if (method == ApiResponseMethod.postMethod) {
        if (passHeader) {
          initToken();
          response = await http.post(url, body:body ?? params, headers:
          {
            "Content-Type": "application/json",
            "Authorization": "$tokenType $token",
          }
          );
        } else {
          response = await http.post(
            url,
            body: params,
          );
        }
      } else if (method == ApiResponseMethod.putMethod) {
        if (passHeader) {
          initToken();
          var body = jsonEncode(params);

          response = await http.put(url, body: body, headers: {
            "Content-Type": "application/json",
            "Authorization": "$tokenType $token",
          });
        } else {
          response = await http.put(
            url,
            body: params,
          );
        }
      }

      // patch method

      else if (method == ApiResponseMethod.patchMethod) {
        if (passHeader) {
          initToken();
          var body = jsonEncode(params);
          response = await http.patch(url, body: body, headers: {
            "Content-Type": "application/json",
            "Authorization": "$tokenType $token",
          });
        } else {
          response = await http.patch(
            url,
            body: params,
          );
        }
      }
      //

      // else if (method == ApiResponseMethod.deleteMethod) {
      //   if (passHeader) {
      //     initToken();
      //     response = await http.delete(url, body: jsonEncode(params), headers: {
      //       "Content-Type": "application/json",
      //       "Authorization": "$tokenType $token"
      //     });
      //   } else {
      //     response = await http.delete(url);
      //   }
      // }
      else if (method == ApiResponseMethod.deleteMethod) {
        if (passHeader) {
          response = await http.delete(url, headers: {
            "Content-Type": "application/json",
            "Authorization": "$tokenType $token"
          },
            body: params

          );
        } else {
          response = await http.delete(url);
        }
      }


      else if (method == ApiResponseMethod.updateMethod) {
        response = await http.patch(url);
      } else {
        if (passHeader) {
          initToken();
          response = await http.get(url, headers: {
            "Content-Type": "application/json",
            "Authorization": "$tokenType $token",
          });
        } else {
          response = await http.get(url);
        }
      }

      print(url.toString());
      print(response.body);
      ApiAuthorizationResponseModel authorizationResponseModel =
      ApiAuthorizationResponseModel.fromJson(jsonDecode(response.body));
      if (response.statusCode == 200) {
        try {

          if (authorizationResponseModel.message == 'Unauthenticated') {
            sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
            sharedPreferences.remove(SharedPreferenceHelper.token);
            Get.offAllNamed(AppRoute.signInScreen);
          }
        } catch (e) {
          e.toString();
        }

        return ApiResponseModel(response.statusCode, authorizationResponseModel.message.toString(), response.body);
      }else if (response.statusCode == 401) {
        sharedPreferences.setBool(SharedPreferenceHelper.rememberMeKey, false);
        sharedPreferences.remove(SharedPreferenceHelper.userIdKey);
        Get.offAllNamed(AppRoute.signInScreen);
        return ApiResponseModel(401, "Unauthorized".tr, response.body);
      }
      else{
        
        print("====================This is msg ${authorizationResponseModel.message.toString()}");
        return ApiResponseModel(response.statusCode, authorizationResponseModel.message.toString(), response.body);

      }


      // else if (response.statusCode == 201) {
      //   return ApiResponseModel(201, 'Success', response.body);
      // } else if (response.statusCode == 500) {
      //   return ApiResponseModel(500, "Internal Server Error".tr, response.body);
      // } else {
      //   return ApiResponseModel(499, "Something went wrong".tr, response.body);
      // }
    } on SocketException {
      return ApiResponseModel(503, "No internet connection".tr, '');
    } on FormatException {
      return ApiResponseModel(400, "Bad Response Request".tr, '');
    } catch (e) {
      return ApiResponseModel(499, "Client Closed Request".tr, '');
    }
  }

  String token = '';
  String tokenType = '';

  initToken() {
    if (sharedPreferences.containsKey(SharedPreferenceHelper.accessTokenKey)) {
      String? t =
          sharedPreferences.getString(SharedPreferenceHelper.accessTokenKey);
      String? tType =
          sharedPreferences.getString(SharedPreferenceHelper.accessTokenType);
      token = t ?? '';
      tokenType = tType ?? 'Bearer';
    } else {
      token = '';
      tokenType = 'Bearer';
    }
  }
}
