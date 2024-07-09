import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/auth/forgot_password/forgot_password_screen.dart';
import 'package:resid_plus/view/screen/auth/new_password/new_pass_controller/new_pass_controller.dart';
import 'package:resid_plus/view/widgets/buttons/custom_button.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:resid_plus/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(NewPassController(apiService: Get.find()));
    DeviceUtils.authUtils();
    super.initState();
  }
  /// =============================== url launcher ========================>
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch ');
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewPassController>(builder: (controller) {
      return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppColors.black5,
          appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 64),
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsetsDirectional.only(
                    start: 20, end: 20, top: 24),
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () => Get.to(() => const ForgotPassword()),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios,
                          color: AppColors.blackPrimary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        "Set New Password".tr,
                        style: GoogleFonts.raleway(
                          color: const Color(0xFF333333),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              )),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 46),
                Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your password must have 8-10 characters.".tr,
                            maxLines: 2,
                            style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackPrimary
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        CustomTextField(
                          title: 'New Password'.tr,
                          hintText: 'Enter new password'.tr,
                          textEditingController: controller.passwordController,
                          isPassword: true,
                          validator: (value){
                            if(value.isEmpty){
                              return "Please enter your password".tr;
                            }
                            else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(controller.passwordController.text)){
                              return "Please use strong password".tr
                              ;
                            }
                            else if(value.length < 8){
                              return "Please use 8 character long password".tr;
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 16.h),
                        CustomTextField(
                          isPassword: true,
                          title: 'Confirm Password'.tr,
                          hintText: 'Confirm password'.tr,
                          textEditingController: controller.confirmPasswordController,
                          validator: (value){
                            if(value.isEmpty){
                              return "Please enter your password".tr;
                            }
                            else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(controller.confirmPasswordController.text)){
                              return "Please use strong password".tr;
                            }
                            else if(value.length < 8){
                              return "Please use 8 character long password".tr;
                            }
                            else if(controller.passwordController.text != controller.confirmPasswordController.text){
                              return "Password doesn't match".tr;
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          floatingActionButton:  FloatingActionButton(onPressed: () {
            const url1 = "https://wa.me/+15144309730/?text=Hello%20Franck";
            _launchUrl(url1.toString());
          },
            shape: const CircleBorder(),
            backgroundColor:  Color(0xff25d366),

            child: const FaIcon(FontAwesomeIcons.whatsapp,color: Color(0xffffffff) ,size: 40,),
          ),
          bottomNavigationBar: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(bottom: 24.0, left: 20, right: 20),
            child: controller.isLoading ? const CustomElevatedLoadingButton(buttonColor: AppColors.blackPrimary)  : CustomButton(
              onTap: () {
                if(formKey.currentState!.validate()){
                  controller.newPass();
                }
              },
              title: 'Reset'.tr,
            ),
          ),
        ),
      );
    });
  }
}
