import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/core/helper/shear_preference_helper.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewPassController extends GetxController {
  ApiService apiService;
  NewPassController({required this.apiService});

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;
  Future<void> newPass() async {

    isLoading = true;
    update();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString(
      SharedPreferenceHelper.email,
    );

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.resetPass}";

    String responseMethod = ApiResponseMethod.postMethod;
    Map<String, dynamic> params = {
      "email": email,
      "password": passwordController.text
    };

    ApiResponseModel responseModel = await apiService.request(url, responseMethod, params, passHeader: false);

    if (responseModel.statusCode == 200) {

      Get.offNamed(AppRoute.signInScreen);

      Utils.toastMessage(responseModel.message);
    } else {
      Utils.toastMessage(responseModel.message);
    }

    isLoading = false;
    update();
  }
}
