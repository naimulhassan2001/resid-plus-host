import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/core/helper/shear_preference_helper.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InactiveController extends GetxController {

  InactiveController({required this.apiService});

  ApiService apiService;
  bool isSubmit = false;
  Future<void> inActiveResidence({required String id, required Status  type}) async {
    isSubmit = true;
    update();

    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString(SharedPreferenceHelper.accessTokenKey);
    var request = http.MultipartRequest(
      "PUT", Uri.parse("${ApiUrlContainer.baseUrl}${ApiUrlContainer.searchResidence}/$id"),);

    String statusType = type == Status.active? "active":"inactive";

    request.fields["status"] =statusType;

    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Authorization'] = "Bearer $token";
    var response = await request.send();
    if (response.statusCode == 201) {
      Utils.toastMessage("Successfully residence updated".tr);
      Get.toNamed(AppRoute.myResidenceScreen);
      update();
    }
    else{
      Utils.toastMessage("something wrong".tr);
    }

  }
}
enum Status{
  active,inactive
}