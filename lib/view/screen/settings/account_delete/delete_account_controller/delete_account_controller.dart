import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/helper/shear_preference_helper.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/settings/account_delete/delete_account_model/delete_account_model.dart';
import 'package:resid_plus/view/screen/settings/account_delete/delete_account_repo/delete_account_repo.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountController extends GetxController {
  DeleteAccountRepo deleteAccountRepo;
  DeleteAccountController({required this.deleteAccountRepo});

  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<DeleteAccountModel> deleteAccount() async {
    isLoading = true;
    update();

    ApiResponseModel responseModel = await deleteAccountRepo.deleteAccount(password: passwordController.text);
    DeleteAccountModel deleteAccountModel; //

    print("${passwordController.text}");// Define the variable here

    if (responseModel.statusCode == 200) {
      deleteAccountModel = DeleteAccountModel.fromJson(jsonDecode(responseModel.responseJson));
      print(responseModel.statusCode);
      goToNextStep(deleteAccountModel);
    } else {
      passwordController.text = "";
      isLoading = false;
      update();
      Utils.snackBar("Error".tr, "Invalid Password".tr);
      // You should handle the case where there's an error. It's also recommended to return an appropriate response in this case.
      return DeleteAccountModel(); // Return a default value or handle the error accordingly.
    }
    isLoading = false;
    update();
    return deleteAccountModel; // Return the variable here
  }

  goToNextStep(DeleteAccountModel deleteAccountModel) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferenceHelper.userIdKey);
    await prefs.remove(SharedPreferenceHelper.accessTokenKey);
    await prefs.remove(SharedPreferenceHelper.accessTokenType);
    await prefs.remove(SharedPreferenceHelper.rememberMeKey);
    await prefs.remove(SharedPreferenceHelper.userEmailKey);
    await prefs.remove(SharedPreferenceHelper.phoneNumberKey);
    await prefs.remove(SharedPreferenceHelper.usernameKey);
    await prefs.remove(SharedPreferenceHelper.dobKey);
    // await prefs.remove(SharedPreferenceHelper.);
    Get.offAllNamed(AppRoute.signInScreen);
    Utils.snackBar("Successful".tr, "Account Deleted Successful".tr);
  }

}