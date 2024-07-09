import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/settings/change_password/change_password_repo/change_password_repo.dart';

class ChangePasswordController extends GetxController {
  ChangePasswordRepo repo;
  ChangePasswordController({required this.repo});

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isSubmit = false;

  Future<void> changePassword() async {
    isSubmit = true;
    update();

    ApiResponseModel responseModel = await repo.changePassword(
      currentPassword: currentPasswordController.text,
      newPassword: newPasswordController.text,
    );

    if (responseModel.statusCode == 200) {
      // ChangePasswordModel model = ChangePasswordModel.fromJson(jsonDecode(responseModel.responseJson));
      Utils.toastMessage(responseModel.message);

      Get.back();
    } else if (responseModel.statusCode == 503) {
      Get.offAllNamed(AppRoute.noInternet);
    } else if (responseModel.statusCode == 401) {
      Utils.toastMessage(responseModel.message);
    } else {
      Utils.toastMessage(responseModel.message);
    }

    clearData();

    isSubmit = false;
    update();
  }

  clearData() {
    newPasswordController.text = "";
    currentPasswordController.text = "";
    confirmPasswordController.text = "";
  }
}
