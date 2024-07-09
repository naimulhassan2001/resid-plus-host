import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/settings/change_password/change_password_controller/change_password_controller.dart';
import 'package:resid_plus/view/screen/settings/change_password/change_password_repo/change_password_repo.dart';
import 'package:resid_plus/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus/view/widgets/buttons/custom_button.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:resid_plus/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

final formKey = GlobalKey<FormState>();

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  void initState() {
    DeviceUtils.innerUtils();

    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(ChangePasswordRepo(apiService: Get.find()));
    Get.put(ChangePasswordController(repo: Get.find()));
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.innerUtils();

    super.dispose();
  }
  /// =============================== url launcher ========================>
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch ');
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.black5,
        appBar: CustomAppBar(
          appBarContent: GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              children: [
                const Icon(Icons.arrow_back_ios,
                    color: AppColors.blackPrimary, size: 18),
                const SizedBox(width: 8),
                Text(
                  "changePassword".tr,
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
        body: GetBuilder<ChangePasswordController>(
          builder: (controller) => SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    title: "Current Password".tr,
                    hintText: "Enter password".tr,
                    textEditingController: controller.currentPasswordController,
                    isPassword: true,
                    validator: (value){
                      if(value.isEmpty){
                        return "Please enter your password".tr;
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    title: "New Password".tr,
                    hintText: "Enter new Password".tr,
                    textEditingController: controller.newPasswordController,
                    isPassword: true,
                    validator: (value){
                      if(value.isEmpty){
                        return "Please enter your password".tr;
                      }
                      else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(controller.newPasswordController.text)){
                        return "Please use uppercase,lowercase,spacial character and number".tr ;
                      }
                      else if(value.length < 8){
                        return "Please use 8 character long password".tr;
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    title: "Confirm New Password".tr,
                    hintText: "Enter confirm Password".tr,
                    textEditingController: controller.confirmPasswordController,
                    isPassword: true,
                    validator: (value){
                      if(value.isEmpty){
                        return "Please enter your password".tr;
                      }
                      else if(controller.newPasswordController.text != controller.confirmPasswordController.text){
                        return "Password doesn't match".tr;
                      }

                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        floatingActionButton:  FloatingActionButton(onPressed: () {
          const url1 = "https://wa.me/+15144309730/?text=Hello%20Franck";
          _launchUrl(url1.toString());
        },
          shape: const CircleBorder(),
          backgroundColor:  const Color(0xff25d366),

          child: const FaIcon(FontAwesomeIcons.whatsapp,color: Color(0xffffffff) ,size: 40,),
        ),
        bottomNavigationBar: GetBuilder<ChangePasswordController>(builder: (controller) {
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 24, left: 20, right: 20),
            child: controller.isSubmit ? const CustomElevatedLoadingButton() : CustomButton(
              onTap: () {
                if(formKey.currentState!.validate()){
                  controller.changePassword();
                }
              },
              title: 'continue'.tr,
            ),
          );
        }),
      ),
    );
  }
}
