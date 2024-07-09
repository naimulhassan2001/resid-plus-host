import 'dart:convert';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/view/screen/settings/privacy/privacy_policy_model/privacy_policy_model.dart';
import 'package:resid_plus/view/screen/settings/privacy/privacy_policy_repo/privacy_policy_repo.dart';

class PrivacyPolicyController extends GetxController {
  PrivacyPolicyRepo privacyPolicyRepo;
  PrivacyPolicyController({required this.privacyPolicyRepo});

  PrivacyPolicyModel privacyPolicyModel = PrivacyPolicyModel();

  bool isLoading = false;

String data = "";

  getPrivacyPolicyData() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel =
        await privacyPolicyRepo.privacyPolicyResponse();
    print("status code: ${responseModel.statusCode}");

    if (responseModel.statusCode == 201) {
      privacyPolicyModel =
          PrivacyPolicyModel.fromJson(jsonDecode(responseModel.responseJson));


      data = privacyPolicyModel.data?.attributes?.content??"";

    }else {
      privacyPolicyModel =
          PrivacyPolicyModel.fromJson(jsonDecode(responseModel.responseJson));
      // print(privacyPolicyModel.data!.attributes!.content ?? "Error");
      // Utils.toastMessageCenter(privacyPolicyModel.message ?? "Error");
    }
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    getPrivacyPolicyData();
    super.onInit();
  }
}



