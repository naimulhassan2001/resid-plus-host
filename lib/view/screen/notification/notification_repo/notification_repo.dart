import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/service/api_service.dart';

class NotificationRepo{

  ApiService apiService;
  NotificationRepo({required this.apiService});

  Future notificationsResponse()async{

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.notificationEndPoint}";
    String responseMethod =  ApiResponseMethod.getMethod;

    ApiResponseModel responseModel = await apiService.request(url, responseMethod, null,passHeader: true);

    return responseModel;


  }

}