import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/helper/shear_preference_helper.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/auth/sign_in/sign_in_model/sign_in_model.dart';
import 'package:resid_plus/view/screen/auth/sign_in/sign_in_repo/sign_in_repo.dart';
import 'package:resid_plus/view/screen/home/home_screen.dart';

class SignInController extends GetxController {
  SignInRepo signInRepo;

  SignInController({required this.signInRepo});

  final TextEditingController emailController =
      TextEditingController(text: kDebugMode ? 'host@gmail.com' : '');
  final TextEditingController passwordController =
      TextEditingController(text: kDebugMode ? 'hellohost' : '');

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  late bool emailEdited = false;

  bool isLoading = false;

  SignInModel signInModel = SignInModel();

  String role = "";

  //Sign In Function that call for Authentication
  Future<void> signInUser() async {
    isLoading = true;
    update();

    //Call Api Using ApiResponseModel That is Use for the formatting the data
    try {
      ApiResponseModel responseModel = await signInRepo.signInUser(
          email: emailController.text.toString(),
          password: passwordController.text.toString());

      if (responseModel.statusCode == 200) {
        signInModel =
            SignInModel.fromJson(jsonDecode(responseModel.responseJson));
        role = signInModel.data?.attributes?.role ?? "";

        if (role == "host") {
          await gotoNextStep(signInModel);
        } else {
          Utils.toastMessage("Invalid User");
        }
      } else {
        Utils.toastMessage(responseModel.message);
      }
    } on Exception catch (e) {
      Utils.toastMessage("Something went wrong $e");
    }

    clearData();
    isLoading = false;
    update();
  }

  gotoNextStep(SignInModel signInModel) async {
    bool emailVerified =
        signInModel.data!.attributes!.emailVerified == false ? false : true;
    bool isDeleted =
        signInModel.data!.attributes!.isDeleted == false ? false : true;

    // User ID

    await signInRepo.apiService.sharedPreferences.setString(
        SharedPreferenceHelper.userIdKey,
        signInModel.data!.attributes!.id.toString());

    // User email

    await signInRepo.apiService.sharedPreferences.setString(
        SharedPreferenceHelper.email,
        signInModel.data!.attributes!.email ?? "");

    // User Token

    await signInRepo.apiService.sharedPreferences.setString(
        SharedPreferenceHelper.accessTokenKey, signInModel.data!.token ?? "");

    // User Type

    await signInRepo.apiService.sharedPreferences
        .setString(SharedPreferenceHelper.accessTokenType, "Bearer");

    if (emailVerified == false) {
      Get.offNamed(AppRoute.otpScreen);
      return;
    }

    if (emailVerified == true) {
      Get.off(() => const HomeScreen());
      Utils.toastMessage("Sign in successfully".tr);
    } else if (isDeleted == true) {
      Utils.toastMessage("You are Banned from this app");
      return;
    } else {
      Utils.toastMessage("Enter valid Email or Password");
    }
  }

  clearData() {
    emailController.text = "";
    passwordController.text = "";
  }
}
