

import '../../../../../../../core/global/api_response_method.dart';
import '../../../../../../../core/global/api_response_model.dart';
import '../../../../../../../core/global/api_url_container.dart';
import '../../../../../../../service/api_service.dart';

class CountryRepo {
  ApiService apiService;
  CountryRepo({required this.apiService});

  Future<ApiResponseModel> getCountry() async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.countryPaymentEndpoint}";

    String requestMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel =
    await apiService.request(uri, requestMethod, null, passHeader: true);

    return responseModel;
  }
}