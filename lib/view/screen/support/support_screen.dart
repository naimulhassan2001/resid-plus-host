import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/support/supper_repo/support_repo.dart';
import 'package:resid_plus/view/screen/support/support_controller/support_controller.dart';
import 'package:resid_plus/view/widgets/app_bar/custom_app_bar.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {

  @override
  void initState() {
    DeviceUtils.innerUtils();
    super.initState();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(SupportRepo(apiService: Get.find()));
    final controller = Get.put(SupportController(supportRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getSupportData();
    });
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
                  "support".tr,
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
        body: GetBuilder<SupportController>(builder: (controller)=> controller.isLoading? const Center(child:
        CircularProgressIndicator(color: AppColors.blackPrimary,)) : controller.supportModel.data?.attributes?.content == null ? Center(
            child: Text(
                "No Data Found".tr,
                style: GoogleFonts.raleway(fontSize: 20))) : SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(vertical: 24, horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Html(
                      data:controller.supportModel.data?.attributes?.content ?? "",
                  ),
                ]
            ))
        ),
      ),
    );
  }
}
