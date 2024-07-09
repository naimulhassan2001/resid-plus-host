import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/auth/forgot_password/forgot_password_screen.dart';
import 'package:resid_plus/view/screen/auth/sign_in/sign_in_controller/sign_in_controller.dart';
import 'package:resid_plus/view/screen/auth/sign_in/sign_in_repo/sign_in_repo.dart';
import 'package:resid_plus/view/screen/auth/sign_up/sign_up_screen.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_button.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:resid_plus/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();



  @override
  void initState() {
    DeviceUtils.authUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(SignInController(signInRepo: Get.find()), permanent: true);
    Get.put(SignInRepo(apiService: Get.find()), permanent: true);
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.bottomNavUtils();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: AppColors.black5,
        appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 64),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsetsDirectional.only(
                  start: 20, end: 20, top: 24, bottom: 0),
              color: AppColors.transparentColor,
              alignment: Alignment.center,
              child: Text(
                "welcome".tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
        body: GetBuilder<SignInController>(builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(
                vertical: 24, horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SvgPicture.asset("assets/images/sign_in_logo.svg"),
                  SizedBox(height: 24.h),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    title: 'email'.tr,
                    focusNode: controller.emailFocusNode,
                    nextFocus: controller.passwordFocusNode,
                    hintText: 'Enter your email'.tr,
                    textInputAction: TextInputAction.next,
                    textEditingController: controller.emailController,
                    onChanged: (value) {
                      return ;
                    },
                    validator: (value){
                      if(value.isEmpty){
                        return "Please enter your email".tr;
                      }
                      else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(controller.emailController.text)){
                        return "Please enter your valid email".tr;
                      }
                      else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 8.h),
                  CustomTextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    title: 'password'.tr,
                    focusNode: controller.passwordFocusNode,
                    hintText: 'Enter your Password'.tr,
                    textEditingController: controller.passwordController,
                    isPassword: true,
                    validator: (value){
                      if(value.isEmpty){
                        return "Please enter your password".tr;
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgotPassword());
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password".tr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackPrimary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  controller.isLoading ? const CustomElevatedLoadingButton(buttonColor: AppColors.blackPrimary) : CustomElevatedButton(
                    onPressed: () async{
                      if(formKey.currentState!.validate()){
                        await controller.signInUser();

                      }
                    },
                    titleText: 'signIn'.tr,
                  ),
                  SizedBox(height: 37.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'doYouHaveAc'.tr,
                        style: GoogleFonts.raleway(
                          color: AppColors.blackPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const SignUpScreen());
                        },
                        child: Text(
                          'signUp'.tr,
                          style: GoogleFonts.raleway(
                            color: AppColors.blackPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }),
        floatingActionButton:  FloatingActionButton(onPressed: () {
          const url1 = "https://wa.me/+15144309730/?text=Hello%20Franck";
          _launchUrl(url1.toString());
        },
          shape: const CircleBorder(),
          backgroundColor:  const Color(0xff25d366),

          child: const FaIcon(FontAwesomeIcons.whatsapp,color: Color(0xffffffff) ,size: 40,),
        ),
      ),
    );
  }
  /// =============================== url launcher ========================>
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch ');
    }
  }
}
