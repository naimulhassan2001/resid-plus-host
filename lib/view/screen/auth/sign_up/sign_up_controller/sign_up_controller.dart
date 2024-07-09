import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/helper/shear_preference_helper.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/auth/otp/otp_screen.dart';
import 'package:resid_plus/view/screen/auth/sign_up/contry_model/country_model.dart';
import 'package:resid_plus/view/screen/auth/sign_up/sign_up_repo/sign_up_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  SignUpRepo signUpRepo;
  SignUpController({required this.signUpRepo});

  bool isLoading = false;
  bool isStore = false;

  // SignUpModel signUpModel = SignUpModel();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();


  String username = "";
  String email = "";
  String dob = "";
  String address = "";
  String year = "";
  String month = "";
  String day = "";
  String phoneNumber = "";
   String countryCode = "";
  String withdrawMethod = "";


   Attribute dropdownvalue =Attribute();
  Attribute selectedCountry= Attribute();
  List<Attribute>countyName = [];
  CountryModel countryModel = CountryModel();

  Future<void>getCountry() async{
    isLoading=true;
 ApiResponseModel responseModel =   await signUpRepo.responseCountry();
 if(responseModel.statusCode==200){
      countryModel = CountryModel.fromJson(jsonDecode(responseModel.responseJson));
      countyName = countryModel.data!.attributes!;
      selectedCountry=countyName[0];
      dropdownvalue=countyName[0];
      print("====================Humayun Kabir${countyName.length}");
      print("==================hummmmmmmmmmmmmmmmmmmmma=>${selectedCountry}");

      isLoading=false;
      update();
    }
  }
  // store data in local storage
  void storeDataInLocal() async {
    isStore = true;
    update();
    username = signUpRepo.apiService.sharedPreferences.setString(SharedPreferenceHelper.usernameKey, nameController.text.trim()).toString();
    email = signUpRepo.apiService.sharedPreferences.setString(SharedPreferenceHelper.emailKey, emailController.text.trim()).toString();
    dob = signUpRepo.apiService.sharedPreferences.setString(SharedPreferenceHelper.dobKey, "$year-$month-$day").toString();
    phoneNumber = signUpRepo.apiService.sharedPreferences.setString(SharedPreferenceHelper.phoneNumberKey, "$countryCode${phoneController.text.trim().toString()}").toString();
    address = signUpRepo.apiService.sharedPreferences.setString(SharedPreferenceHelper.addressKey, addressController.text.trim()).toString();
      Get.offAndToNamed(AppRoute.otpScreen);
    isStore = false;
    update();
  }

  Future<void> signUpUser() async {
    // storeDataInLocal();
    isLoading = true;
    update();
    countryCode = dropdownvalue.countryCode?? "";
    phoneNumber = "$countryCode${phoneController.text.trim().toString()}";
    // print("length: ${phoneNumber.length}");
    ApiResponseModel responseModel = await signUpRepo.createUser(
        countryId: selectedCountry.id??"",
        fullName: nameController.text,
        email: emailController.text,
        phoneNumber: phoneNumber,
        address: addressController.text??" ",
        dateOfBirth: "$year-$month-$day",
        password: passwordController.text.trim().toString());

    if (responseModel.statusCode == 201) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(SharedPreferenceHelper.email, emailController.text.trim());

      clearData();
      Get.off(() => const OtpScreen(isHome: true));
      Utils.toastMessage("Sign up successfully".tr);
    }
    else {
      Utils.toastMessage(responseModel.message.toString());
      clearData();
    }
    isLoading = false;
    update();
  }
  Future<void> pickedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050),
        builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: AppColors.blackPrimary,),),
            child: child!));
    if (picked != null) {
      year = picked.year.toString();
      month = picked.month.toString();
      day = picked.day.toString();
      update();
    }
  }

  clearData() {
    nameController.text = "";
    emailController.text = "";
    phoneController.text = "";
    addressController.text = "";
    passwordController.text = "";
    confirmPasswordController.text = "";
    year = "";
    month = "";
    day = "";
  }
}
