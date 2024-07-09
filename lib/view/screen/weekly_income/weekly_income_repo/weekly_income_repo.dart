import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/service/api_service.dart';

class WeeklyIncomeRepo{

  ApiService apiService ;

  WeeklyIncomeRepo({required this.apiService});

  Future <ApiResponseModel> weeklyIncomeResponse() async {

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.weeklyIncome}";

    String requestMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel  = await apiService.request(url, requestMethod, null,passHeader: true);

    return responseModel;

  }
}