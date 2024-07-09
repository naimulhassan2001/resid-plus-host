import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/service/api_service.dart';
class MyResidenceRepo {
  ApiService apiService;
  MyResidenceRepo({required this.apiService});

  Future<ApiResponseModel> myResidences({required String search ,required String pageNo}) async {
    String uri =
        "${ApiUrlContainer.baseUrl}${ApiUrlContainer.myResidences}$search";

    String requestMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel =
        await apiService.request(uri, requestMethod, null, passHeader: true);

    return responseModel;
  }
}
