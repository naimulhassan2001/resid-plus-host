import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/service/api_service.dart';

class FaqRepo{

  ApiService apiService;
  FaqRepo({required this.apiService});
 Future<ApiResponseModel> faqResponse() async{
   String  url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.faqsEndpoint}";
   String requestMethod = ApiResponseMethod.getMethod;


   ApiResponseModel responseModel = await apiService.request(url, requestMethod, null,passHeader:  true);

   return responseModel;

 }

}