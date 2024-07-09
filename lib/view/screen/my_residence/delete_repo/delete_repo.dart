import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/home/home_residence_controller/home_residence_controller.dart';

class DeleteResidence extends GetxController {
  DeleteResidence({required this.apiService});

  ApiService apiService;

  Future<ApiResponseModel> deleteResidence({required String id}) async {
    var controller = Get.find<HomeController>();

    String url =
        "${ApiUrlContainer.baseUrl}${ApiUrlContainer.searchResidence1}/$id";
    String requestMethod = ApiResponseMethod.deleteMethod;

    ApiResponseModel responseModel = await apiService.request(url, requestMethod, null, passHeader: true);

    if (responseModel.statusCode == 201) {
      update();
      Get.offNamed(AppRoute.homeScreen);
      Utils.toastMessage(responseModel.message);

    } else if (responseModel.statusCode == 503) {
      Get.offAllNamed(AppRoute.noInternet);
    } else {
      Utils.toastMessage("Something went wrong");
    }
    return responseModel;
  }

}
