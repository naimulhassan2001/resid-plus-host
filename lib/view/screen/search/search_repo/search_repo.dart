import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/service/api_service.dart';

class SearchResidenceRepo {
  ApiService apiService;
  SearchResidenceRepo({required this.apiService});

  Future<ApiResponseModel> mySearchedResidence({required String search}) async {

    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.searchResidence}&search=$search";
    print("========> url: $uri");

    String requestMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);

    return responseModel;
  }

  Future<ApiResponseModel> filterResidence({required String filter}) async {

    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.searchResidence}?category=$filter" ;
    print("========> url: $uri");

    String requestMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);

    return responseModel;
  }
}
