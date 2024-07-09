import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/service/api_service.dart';

class ChangePasswordRepo{

  ApiService apiService;
  ChangePasswordRepo({required this.apiService});

  Future<ApiResponseModel> changePassword({required String currentPassword,
    required String newPassword,}) async{

    String uri = "${ApiUrlContainer.baseUrl}users";

    String requestMethod = ApiResponseMethod.patchMethod;

    Map<String, String> params = {
      "currentPassword" : currentPassword,
      "newPassword" : newPassword,
       // "reTypedPassword" : retypePassword,
    };
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, params, passHeader: true);

    return responseModel;
  }
}
