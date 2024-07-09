import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/core/helper/shear_preference_helper.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/auth/otp/otp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPassController extends GetxController {
  ApiService apiService;
  ForgetPassController({required this.apiService});

  TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  Future<ApiResponseModel> forgetPass() async {
    isLoading = true;
    update();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferenceHelper.email, emailController.text);

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.forgetPass}";

    String responseMethod = ApiResponseMethod.postMethod;
    Map<String, dynamic> params = {"email": emailController.text};

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, params, passHeader: false);

    if (responseModel.statusCode == 201) {
      Get.off(const OtpScreen(isHome: false));
      Utils.toastMessage("Success".tr);
    } else {
      Utils.toastMessage(responseModel.message);
    }

    emailController.text = "";

    isLoading = false;
    update();

    return responseModel;
  }
}
