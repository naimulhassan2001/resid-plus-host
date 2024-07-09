import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/core/helper/date_converter_helper.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/service/ads_service.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_icons.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/edit_profile/edit_profile_controller/edit_profile_controller.dart';
import 'package:resid_plus/view/screen/profile/inner_widget/profile_details_card.dart';
import 'package:resid_plus/view/screen/profile/profile_controller/profile_controller.dart';
import 'package:resid_plus/view/screen/profile/profile_repo/profile_repo.dart';
import 'package:resid_plus/view/widgets/bottom_nav/custom_bottom_nav_bar.dart';
import 'package:resid_plus/view/widgets/buttons/custom_button_with_icon.dart';
import 'package:resid_plus/view/widgets/image/custom_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/buttons/custom_elevated_button.dart';
import '../../widgets/text/custom_text.dart';
import 'dart:io' show Platform;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiService: Get.find()));
    final controller = Get.put(ProfileController(profileRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.profile();
    });

    DeviceUtils.bottomNavUtils();
    showAds();
    super.initState();
  }

  showAds() {
    try {
      AdsServices.interstitialAd.show();
      AdsServices.loadInterstitialAd();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 64),
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsetsDirectional.only(
                  start: 20, end: 20, top: 24, bottom: 0),
              color: Colors.transparent,
              child: Text(
                "Profile".tr,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
        body: GetBuilder<ProfileController>(builder: (controller) {
          final editingController = Get.find<EditProfileController>();

          return LayoutBuilder(
              builder: (context, constraints) => controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.blackPrimary),
                    )
                  : SingleChildScrollView(
                      padding: const EdgeInsetsDirectional.symmetric(
                          vertical: 24, horizontal: 20),
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              margin:
                                  const EdgeInsets.only(top: 24, bottom: 24),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: AppColors.black60,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      editingController.nameController =
                                          TextEditingController(
                                              text: controller.username);
                                      editingController.numberController =
                                          TextEditingController(
                                              text: controller.phoneNumber);
                                      editingController.addressController =
                                          TextEditingController(
                                              text: controller.address);
                                      Get.toNamed(AppRoute.profileEditScreen,
                                          arguments: controller.profileModel);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        gradient: AppColors.darkColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: CachedNetworkImageProvider(
                                                              controller
                                                                  .profileImage))),
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Text(
                                                    controller.username,
                                                    textAlign: TextAlign.left,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.raleway(
                                                        color: AppColors
                                                            .whiteColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const CustomImage(
                                            imageSrc: AppIcons.editIcon,
                                            size: 24,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  ProfileDetailsCard(
                                    bottomText: controller.email,
                                  ),
                                  ProfileDetailsCard(
                                      topText: "phoneNum".tr,
                                      bottomText: controller.phoneNumber,
                                      icon: Icons.phone),
                                  ProfileDetailsCard(
                                      icon: Icons.cake_outlined,
                                      topText: "dob".tr,
                                      bottomText: DateConverter
                                          .formatDepositTimeWithAmFormat(
                                              controller.dob)),
                                  ProfileDetailsCard(
                                      icon: Icons.location_on_outlined,
                                      topText: "address".tr,
                                      bottomText: controller.address),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 24),
                            child: CustomButtonWithIcon(
                                onPressed: () {
                                  Get.toNamed(AppRoute.historyScreen);
                                },
                                titleText: "History".tr,
                                iconSrc: AppIcons.historyIcon),
                          ),
                          GestureDetector(
                            onTap: () {
                              _openStore();
                              //  showAlert();
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.whiteColor,
                                  border: Border.all(
                                    color: AppColors.black60,
                                  )),
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 16),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.share,
                                    color: AppColors.black80,
                                  ),
                                  CustomText(
                                    text: "Share the app".tr,
                                    left: 12,
                                    textAlign: TextAlign.start,
                                    color: AppColors.blackPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
        }),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
      ),
    );
  }

  Future<void> _openStore() async {
    String packageName = 'com.residco.residpro';
    Uri appStoreUrl =
        Uri.parse("https://apps.apple.com/in/app/resid-pro/id6473144135");
    String playStoreUrl =
        "https://play.google.com/store/apps/details?id=com.residco.residpro";

    if (await canLaunchUrl(appStoreUrl) && !Platform.isAndroid) {
      await Share.share(appStoreUrl.toString());
    } else if (await canLaunchUrl(Uri.parse(playStoreUrl)) &&
        Platform.isAndroid) {
      await Share.share(playStoreUrl);
    } else {
      throw 'Could not launch store';
    }
  }
}
