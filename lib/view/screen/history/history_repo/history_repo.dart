import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/service/api_service.dart';

class HistoryRepo{
  ApiService apiService;
  HistoryRepo({required this.apiService});

 Future<ApiResponseModel>historyResponse() async{
    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.bookingHistory}";

    String requestMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel = await apiService.request(url, requestMethod,null,passHeader: true );

    return responseModel;
  }

  Future <ApiResponseModel> deleteHistory({required String id }) async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.historyDelete}$id";

    String requestMethod = ApiResponseMethod.deleteMethod;

    ApiResponseModel responseModel = await apiService.request(url, requestMethod, null, passHeader:  true);

    return responseModel;
  }
}