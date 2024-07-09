import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/core/helper/shear_preference_helper.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/auth/new_password/new_password_screen.dart';
import 'package:resid_plus/view/screen/auth/sign_in/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  ApiService apiService;
  bool isHome;

  OtpController({required this.apiService, required this.isHome});

  Future<ApiResponseModel> verifyOtp({
    required String otp,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = isHome
        ? "${ApiUrlContainer.baseUrl}${ApiUrlContainer.verifyOTP}?requestType=verifyEmail"
        : "${ApiUrlContainer.baseUrl}${ApiUrlContainer.forgetPassVerify}";
    final String? email = prefs.getString(SharedPreferenceHelper.email);

    String responseMethod = ApiResponseMethod.postMethod;
    Map<String, dynamic> params = {"email": email, "oneTimeCode": otp};

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, params, passHeader: false);

    if (responseModel.statusCode == 200) {
      isHome
          ? Get.off(() => const SignInScreen())
          : Get.off(() => const NewPasswordScreen());
      Utils.toastMessage(responseModel.message);
    } else {
      Utils.toastMessage(responseModel.message);
    }

    return responseModel;
  }

  Future<ApiResponseModel> resendOTP() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? email = prefs.getString(SharedPreferenceHelper.email);

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.resendOTP}";

    String responseMethod = ApiResponseMethod.postMethod;
    Map<String, dynamic> params = {
      "email": email,
    };

    ApiResponseModel responseModel = await apiService
        .request(url, responseMethod, params, passHeader: false);

    if (responseModel.statusCode == 200) {
      isHome
          ? Get.off(() => const SignInScreen())
          : Get.off(() => const NewPasswordScreen());
      Utils.toastMessage("OTP sent to your email".tr);
    } else {
      Utils.toastMessage(responseModel.message);
    }

    return responseModel;
  }
}
