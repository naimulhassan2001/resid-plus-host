import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/utils/app_colors.dart';

class NoInternetController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  void onConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {


      Get.rawSnackbar(
          messageText: const Text(

            "PLEASE CONNECT TO INTERNET",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          isDismissible: false,
          backgroundColor: AppColors.blackPrimary,
          icon: const Icon(
            Icons.wifi_off_outlined,
            color: Colors.white,
            size: 35,
          ),
          snackStyle: SnackStyle.GROUNDED,

          duration: const Duration(days: 1));

      Get.offAllNamed(AppRoute.noInternet);


    } else {
      if (Get.isSnackbarOpen) {

        Get.closeAllSnackbars();
        Get.offAllNamed(AppRoute.homeScreen);
      }
    }
  }

  @override
  void onInit() {
    _connectivity.onConnectivityChanged.listen((event) {
      onConnectivityChange(event);
    });
    super.onInit();
  }
}
