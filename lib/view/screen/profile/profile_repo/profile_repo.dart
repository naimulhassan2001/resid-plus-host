import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/core/helper/shear_preference_helper.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo {
  ApiService apiService;
  ProfileRepo({required this.apiService});

  Future<ApiResponseModel> profileRepo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString(SharedPreferenceHelper.userIdKey);

    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.userDetails}$id";

    String requestMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);

    return responseModel;
  }
}
