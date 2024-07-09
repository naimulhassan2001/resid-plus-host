import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_utils.dart';

class BookingReqRepo {
  ApiService apiService;
  BookingReqRepo({required this.apiService});

  Future<ApiResponseModel> bookingRequestResponse(
      {required Request request, required String id}) async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.bookingReq}$id";
    String requestMethod = ApiResponseMethod.putMethod;

    Map<String, String> params = {
      "status": request == Request.reserved ? "reserved" : "cancelled"
    };

    ApiResponseModel responseModel =
        await apiService.request(uri, requestMethod, params, passHeader: true);

    if (responseModel.statusCode == 201) {
      Utils.toastMessage(responseModel.message);
    } else {
      Utils.toastMessage(responseModel.message);
    }
    return responseModel;
  }
}

enum Request { cancelled, reserved }
