import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resid_plus/core/helper/shear_preference_helper.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/utils/app_icons.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3),
        () async{
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          String token = prefs.getString(SharedPreferenceHelper.userIdKey)??"";
          if(token.isNotEmpty){
            Get.off(() => const HomeScreen());
          }
          else{
            Get.offAndToNamed(AppRoute.onboardScreen);
          }

        });
    DeviceUtils.splashUtils();
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.onboardUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) => Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF787878), Color(0xFF434343), Colors.black],
            ),
          ),
          child: Center(
            child: SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(AppIcons.logo),
            ),
          ),
        ),
      ),
    );
  }
}
