import 'dart:convert';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/about/about_model/about_model.dart';
import 'package:resid_plus/view/screen/about/about_repo/about_repo.dart';

class AboutController extends GetxController {
  AboutRepo aboutRepo;
  AboutController({required this.aboutRepo});

  bool isLoading = false;
  AboutUsModel aboutUsModel = AboutUsModel();

     String about= "";

  Future<void> aboutUs() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await aboutRepo.aboutUS();
    if (responseModel.statusCode == 201) {
      aboutUsModel =
          AboutUsModel.fromJson(jsonDecode(responseModel.responseJson));
          about = aboutUsModel.data?.attributes?.content ?? "";
      isLoading = false;
      update();
     } else {
      Utils.toastMessage("Server has no data");
      isLoading = false;
      update();
    }
  }
}
