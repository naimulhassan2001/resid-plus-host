import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/settings/privacy/privacy_policy_controller/privacy_policy_controller.dart';
import 'package:resid_plus/view/screen/settings/privacy/privacy_policy_repo/privacy_policy_repo.dart';
import 'package:resid_plus/view/widgets/app_bar/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  @override
  void initState() {

    DeviceUtils.innerUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(PrivacyPolicyRepo(apiService: Get.find()));
   final controller =  Get.put(PrivacyPolicyController(privacyPolicyRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller. getPrivacyPolicyData();
    });
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.innerUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false, bottom: false,
      child: Scaffold(
        appBar: CustomAppBar(
          appBarContent: GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              children: [
                const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18),
                const SizedBox(width: 8),
                Text(
                  "Privacy Policy".tr,
                  style: GoogleFonts.raleway(
                    color: const Color(0xFF333333),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
        body: GetBuilder<PrivacyPolicyController>(
          builder: (controller)=>controller.isLoading ?const Center(
            child: CircularProgressIndicator(color: AppColors.blackPrimary,),
          ) : controller.data.isEmpty ? Center(
              child: Text(
                  "No Data Found".tr,
                  style: GoogleFonts.raleway(fontSize: 20))): SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 24),
            child: Column(
              children: [
                Html(
                  data:controller.data,
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
