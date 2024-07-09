import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_images.dart';
import 'package:resid_plus/utils/app_static_strings.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/edit_profile/edit_profile_controller/edit_profile_controller.dart';
import 'package:resid_plus/view/screen/profile/profile_model/profile_model.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_button.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:resid_plus/view/widgets/custom_text_field/custom_field.dart';
import 'package:resid_plus/view/widgets/image/custom_image.dart';
import 'package:resid_plus/view/widgets/text/custom_text.dart';
class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  void initState() {

    Get.put(ApiService(sharedPreferences: Get.find()));

    Get.put(EditProfileController());

    DeviceUtils.innerUtils();
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.bottomNavUtils();
    super.dispose();
  }
  ProfileModel profileModel = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: GetBuilder<EditProfileController>(builder: (controller) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 64),
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsetsDirectional.only(
                    start: 20, end: 20, bottom: 0, top: 24),
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios,
                          color: AppColors.blackPrimary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        "Edit Profile".tr,
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
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsetsDirectional.symmetric(
                vertical: 24, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => controller.openGallery(context),
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: controller.imageFile == null ? DecorationImage(
                                fit: BoxFit.fill,
                                image: CachedNetworkImageProvider(profileModel.data?.attributes?.user?.image?.publicFileUrl.toString() ?? "")
                              ) : DecorationImage(
                                  fit: BoxFit.fill, image: FileImage(File(controller.imageFile!.path))
                            )
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 30,
                            width: 30,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: const CustomImage(
                              imageSrc: AppImages.cameraImage,
                              imageType: ImageType.png,
                              size: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomField(
                    controller: controller.nameController,
                    text: "name".tr,
                    hintText: "Enter your name".tr
                ),
                CustomField(
                    readOnly: true,
                    controller: controller.emailController = TextEditingController(text: profileModel.data?.attributes?.user?.email.toString() ?? ""),
                    text: AppStaticStrings.email,
                    hintText: AppStaticStrings.email1,
                    top: 8),
                CustomText(
                    text: "phoneNum".tr, bottom: 8, top: 8, fontSize: 14),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 0),
                        padding: const EdgeInsets.all(16),
                        height: 52,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            border: Border.all(
                                color: AppColors.black10,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            // readOnly: true,
                            controller: controller.numberController,
                            textAlign: TextAlign.start,
                            maxLength: 14,
                            scrollPadding: EdgeInsets.zero,
                            decoration: InputDecoration(
                              counterText: "",
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                contentPadding: const EdgeInsets.only(
                                    bottom: 0.0, top: 15.0),
                                hintText: "Enter your number".tr,
                                hintStyle: GoogleFonts.raleway(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.blackPrimary),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CustomField(
                  controller: controller.addressController,
                  text: "address".tr,
                  hintText: "Enter Your Address Here".tr,
                  top: 8,
                  paddingTop: 0,
                  maxLines: 3,
                  hintTextColor: AppColors.blackPrimary,
                  alignment: Alignment.topLeft,
                ),
              ],
            ),
          ),
          bottomNavigationBar: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsetsDirectional.only(
                start: 20, end: 20, bottom: 24),
            child: controller.isSubmit
                ? const CustomElevatedLoadingButton(
                    buttonColor: AppColors.blackPrimary,
                  )
                : CustomElevatedButton(
                    buttonWidth: MediaQuery.of(context).size.width,
                    onPressed: () {
                      controller.updateUserInfo();
                    },
                    buttonColor: AppColors.blackPrimary,
                    titleText: "Save".tr,
                    titleColor: AppColors.whiteColor,
                  ),
          ),
        );
      }),
    );
  }
}
