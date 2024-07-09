import 'dart:convert';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/view/screen/settings/terms/terms_model/terms_model.dart';
import 'package:resid_plus/view/screen/settings/terms/terms_repo/terms_repo.dart';

class TermsConditionController extends GetxController {
    TermsConditionRepo termsConditionRepo;
     TermsConditionController({required this.termsConditionRepo});

  TermsModel termsModel = TermsModel();
    bool isLoading = false;
    getTermsData() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await termsConditionRepo.termsConditionResponse();
    // print("status code: ${responseModel.statusCode}");
    if (responseModel.statusCode == 201) {
      termsModel = TermsModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {

    }
    isLoading = false;
    update();

  }
  @override
  void onInit() {
     getTermsData();
    super.onInit();
  }

}