import 'package:flutter/foundation.dart';
import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/service/api_service.dart';

class HomeRepo{
  ApiService apiService;
  HomeRepo({required this.apiService});
  Future<ApiResponseModel> allResidenceResponse(String ? pageNo) async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allResidenceEndPoint}?page=$pageNo";
    if (kDebugMode) {
      print("============URI${uri}");
    }
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }

  responseNotification() async{
    String uri ="${ApiUrlContainer.baseUrl}${ApiUrlContainer.bannerNoticationEndpoint}";
    String requestMethod =  ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }


/*
  Future<ApiResponseModel> allHotelResponse() async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998a&requestType=all";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }
  Future<ApiResponseModel> allPersonalHouseResponse() async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998c&requestType=all";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }
  Future<ApiResponseModel> newHotelResponse() async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998a&requestType=new";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);

    print("Response: ${responseModel.responseJson.toString()}");
    return responseModel;
  }
  Future<ApiResponseModel> newResidenceResponse() async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998b&requestType=new";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }
  Future<ApiResponseModel> newPersonalHouseResponse() async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998c&requestType=new";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }
  Future<ApiResponseModel> popularHotelResponse() async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998a&requestType=popular";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }
  Future<ApiResponseModel> popularResidenceResponse() async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998b&requestType=popular";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }
  Future<ApiResponseModel> popularPersonalHouseResponse() async{
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.allHotelEndPoint}?category=656184a880b6b1c2ef30998c&requestType=popular";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel = await apiService.request(uri, requestMethod, null, passHeader: true);
    return responseModel;
  }*/
}
