import 'dart:convert';

import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';

import 'package:resid_plus/view/screen/support/supper_repo/support_repo.dart';
import 'package:resid_plus/view/screen/support/support_model/support_model.dart';

class SupportController extends GetxController {
    SupportRepo supportRepo;
    SupportController({required this.supportRepo});

    SupportModel supportModel = SupportModel();

    bool isLoading = false;

   Future<void> getSupportData() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await supportRepo.supportResponse();
    print("status code: ${responseModel.statusCode}");

    if (responseModel.statusCode == 201) {
      supportModel = SupportModel.fromJson(jsonDecode(responseModel.responseJson));
    } else {

    }

    isLoading = false;
    update();

  }

  @override
  void onInit() {
     getSupportData();
    super.onInit();
  }

}