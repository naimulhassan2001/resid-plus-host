import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/about/about_controller/about_controller.dart';
import 'package:resid_plus/view/screen/about/about_repo/about_repo.dart';
import 'package:resid_plus/view/widgets/app_bar/custom_app_bar.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    Get.put(AboutRepo(apiService: Get.find()));
    final controller = Get.put(AboutController(aboutRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.aboutUs();
    });
    DeviceUtils.innerUtils();
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
      top: false,
      bottom: false,
      child: Scaffold(
          appBar: CustomAppBar(
            appBarContent: GestureDetector(
              onTap: () => Get.back(),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back_ios,
                      color: AppColors.blackPrimary, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    "aboutUs".tr,
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
          body: GetBuilder<AboutController>(builder: (controller) {

            return controller.isLoading ? const Center(
              child: CircularProgressIndicator(color: AppColors.blackPrimary,),
            ) : controller.about.isEmpty ? Center(
                child: Text(
                    "No Data Found".tr,
                    style: GoogleFonts.raleway(fontSize: 20))) : SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 24),
              child: Column(
                children: [
                  Html(
                      data:controller.about
                  ),
                ],
              ),
            );
          })),
    );
  }
}
