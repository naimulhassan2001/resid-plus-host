import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_images.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/auth/forgot_password/forget_password_controller/forget_password_controller.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_button.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:resid_plus/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  void initState() {
    DeviceUtils.authUtils();
    Get.put(ForgetPassController(apiService: Get.find()));
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  /// =============================== url launcher ========================>
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch ');
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPassController>(builder: (controller) {
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
                    start: 20, end: 20, top: 24, bottom: 0),
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios,
                          color: AppColors.blackPrimary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        "Forget Password".tr,
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
            padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SvgPicture.asset(AppImages.forgotPasswordImage),
                  SizedBox(height: 24.h),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Please enter your email address to reset your password.".tr,
                            maxLines: 2,
                            style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackPrimary),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        CustomTextField(
                          title: "email".tr,
                          hintText: "Enter your email".tr,
                          textEditingController: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          validator: (value){
                            if(value.isEmpty){
                              return "Please fill up your email field".tr;
                            }
                            else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(controller.emailController.text)){
                              return "Please enter your valid email".tr;
                            }

                            return null;
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: controller.isLoading ? const CustomElevatedLoadingButton() : CustomElevatedButton(
                onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.forgetPass();
                }
              },
              titleText: 'continue'.tr,
            ),
          ),
        ),
      );
    });
  }
}
