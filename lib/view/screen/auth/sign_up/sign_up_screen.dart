import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/auth/sign_in/sign_in_screen.dart';
import 'package:resid_plus/view/screen/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import 'package:resid_plus/view/screen/auth/sign_up/sign_up_repo/sign_up_repo.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_button.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:resid_plus/view/widgets/custom_text_field/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contry_model/country_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final formKey = GlobalKey<FormState>();
  bool isSelected = false;
  int selectedIndex = 0;


  List<Map<String, String>> withdrawMethods = [
    {"image" : "assets/images/wave.png", "method" : "Wave"},
    {"image" : "assets/images/orange.png", "method" : "Orange"},
    {"image" : "assets/images/mtn.png", "method" : "MTN"},
    {"image" : "assets/images/moov.png", "method" : "Moov"},
  ];

  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(SignUpRepo(apiService: Get.find()));
   final contro= Get.put(SignUpController(signUpRepo: Get.find()));

   contro.getCountry();

    DeviceUtils.authUtils();

    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.bottomNavUtils();
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
    return GetBuilder<SignUpController>(builder: (controller) {
      return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            floatingActionButton:  FloatingActionButton(onPressed: () {
              const url1 = "https://wa.me/+15144309730/?text=Hello%20Franck";
              _launchUrl(url1.toString());
            },
              shape: const CircleBorder(),
              backgroundColor:  const Color(0xff25d366),

              child: const FaIcon(FontAwesomeIcons.whatsapp,color: Color(0xffffffff) ,size: 40,),
            ),
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
                  onTap: () => Get.to(() => const SignInScreen()),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios,
                          color: AppColors.blackPrimary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        "signUp".tr,
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
          body: controller.isLoading?const Center(child: CircularProgressIndicator()): SingleChildScrollView(
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20, top: 24, bottom: 24),
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    title: "name".tr,
                    hintText: "Enter your name".tr,
                    textEditingController: controller.nameController,
                    validator: (value){
                      if(value == null || value.toString().isEmpty){
                        return "Please enter your name".tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    title: "email".tr,
                    hintText: "Enter your email".tr,
                    keyboardType: TextInputType.emailAddress,
                    textEditingController: controller.emailController,
                    validator: (value){
                      if(value == null || value.toString().isEmpty){
                        return "Please enter your email".tr;
                      }
                      return null;
                    },
                  ),


                  SizedBox(height: 16.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "dob".tr,
                          style: GoogleFonts.raleway(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackPrimary),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: () => controller.pickedDate(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsetsDirectional.symmetric(vertical: 18),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.transparentColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: controller.year.isEmpty ? const Color(0xffE2E2E2) : AppColors.blackPrimary
                                  )
                                ),
                                child: controller.year.isEmpty ? Text(
                                  "YYYY".tr,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.raleway(
                                    color: const Color(0xff818181),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                  ),
                                ) : Text(
                                  controller.year,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.openSans(
                                    color: AppColors.blackPrimary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                              )
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsetsDirectional.symmetric(vertical: 18),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColors.transparentColor,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: controller.year.isEmpty ? const Color(0xffE2E2E2) : AppColors.blackPrimary
                                      )
                                  ),
                                  child: controller.month.isEmpty ? Text(
                                    "MM".tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.raleway(
                                        color: const Color(0xff818181),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ) : Text(
                                    controller.month.padLeft(2, "0"),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.openSans(
                                        color: AppColors.blackPrimary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                )
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsetsDirectional.symmetric(vertical: 18),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: AppColors.transparentColor,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: controller.year.isEmpty ? const Color(0xffE2E2E2) : AppColors.blackPrimary
                                      )
                                  ),
                                  child: controller.day.isEmpty ? Text(
                                    "DD".tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.raleway(
                                        color: const Color(0xff818181),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ) : Text(
                                    controller.day.padLeft(2, "0"),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.openSans(
                                        color: AppColors.blackPrimary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                      controller.day.isEmpty
                          && controller.month.isEmpty
                          && controller.year.isEmpty ?  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const  SizedBox(height: 8),
                          Text(
                            "*Must enter your date of birth".tr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: AppColors.blackPrimary.withOpacity(.5),
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                            ),
                          )
                        ],
                      ) : const SizedBox()
                    ],
                  ),
                  SizedBox(height: 16.h),

               // country code
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "phoneNum".tr,
                          style: GoogleFonts.raleway(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.blackPrimary
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: controller.selectedCountry.toString().isNotEmpty ? AppColors.black20: AppColors.black5
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.transparentColor,
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  DropdownButton<Attribute>(
                                    underline:const SizedBox(),
                                    value: controller.dropdownvalue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: controller.countyName.map<DropdownMenuItem<Attribute>>((Attribute countryCode) {
                                      return DropdownMenuItem<Attribute>(
                                        value: countryCode,
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(25),
                                              child:  CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                height: 40,
                                                width: 40,
                                                imageUrl: countryCode.countryFlag?.publicFileUrl ?? "",
                                              ),),
                                            // You can add any widget you want here
                                            const SizedBox(width: 8), // Adjust spacing as needed
                                            Text(countryCode.countryCode!),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (Attribute? newValue) {
                                      setState(() {
                                        controller.dropdownvalue = newValue!;
                                      });
                                    },
                                  ),

                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              maxLength: 10,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: controller.phoneController,
                              keyboardType: TextInputType.number,
                              obscureText: false,
                              decoration: InputDecoration(
                                counterText: "",
                                filled: true,
                                fillColor: AppColors.transparentColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFE2E2E2)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFE2E2E2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: const BorderSide(
                                      color: AppColors.blackPrimary),
                                ),
                                hintText: "phoneNum".tr,
                              ),
                            ),
                          )
                        ],
                      ),
                      controller.phoneNumber.isEmpty
                          ?  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const   SizedBox(height: 8),
                          Text(
                            "*Must enter your valid number".tr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: AppColors.blackPrimary.withOpacity(.5),
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                            ),
                          )
                        ],
                      ) : controller.phoneNumber.length < 14
                          ?  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            "*Please use valid phone number".tr,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w400
                            ),
                          )
                        ],
                      ) :
                      const SizedBox()
                    ],
                  ),
                  SizedBox(height: 16.h),
                   Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Select Country".tr,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                           color: controller.selectedCountry.toString().isNotEmpty ? AppColors.black20: AppColors.black5
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.transparentColor,
                    ),
                    child: DropdownButton<Attribute>(
                      underline:const SizedBox(),
                      style: GoogleFonts.raleway(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.blackPrimary
                      ),
                      value: controller.selectedCountry,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.countyName.map<DropdownMenuItem<Attribute>>((Attribute country) {
                        return DropdownMenuItem<Attribute>(
                          value: country,
                          child:  Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child:  CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  height: 40,
                                  width: 40,
                                  imageUrl: country.countryFlag?.publicFileUrl ?? "",
                                ),),
                              // You can add any widget you want here
                              const SizedBox(width: 16), // Adjust spacing as needed
                              Text(country.countryName!),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (Attribute? newValue) {
                        setState(() {
                          controller.selectedCountry = newValue!;
                        }
                        );
                      },
                    ),
                  ),
                ],
              ),



                  const SizedBox(height: 16,),
                  CustomTextField(
                    title: "address".tr,
                    hintText: "Enter your address".tr,
                    textEditingController: controller.addressController,
                  ),
                  // SizedBox(height: 16.h),

                  SizedBox(height: 16.h),
                  CustomTextField(
                    title: "password".tr,
                    hintText: "Enter your Password".tr,
                    textEditingController: controller.passwordController,
                    isPassword: true,
                    validator: (value){
                      if(value.isEmpty){
                        return "Please enter your password".tr;
                      }
                      else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(controller.passwordController.text)){
                        return "Please use uppercase,lowercase,spacial character and number";
                      }
                      else if(value.length < 8){
                        return "Please use 8 character long password".tr;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    title: "confirmPassword".tr,
                    hintText: "Confirm New Password".tr,
                    textEditingController: controller.confirmPasswordController,
                    textInputAction: TextInputAction.done,
                    isPassword: true,
                    validator: (value){
                      if(value.isEmpty){
                        return "Please enter your password".tr;
                      }
                      else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(controller.passwordController.text)){
                        return "Please use uppercase,lowercase,spacial character and number".tr;
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
          ),
          bottomNavigationBar: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20, bottom: 24),
            physics: const ClampingScrollPhysics(),
            child: controller.isLoading ? const CustomElevatedLoadingButton() : CustomElevatedButton(
              onPressed: (){
                if(formKey.currentState!.validate()){
                   // controller.storeDataInLocal();
                  controller.signUpUser();
                }
              },
              titleText: 'continue'.tr,
            ),
          )
        ),
      );
    });
  }
}


