import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/core/helper/shear_preference_helper.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_icons.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/about/about_screen.dart';
import 'package:resid_plus/view/screen/add_residence/add_update_residence_screen.dart';
import 'package:resid_plus/view/screen/booking_request/booking_request_screen.dart';
import 'package:resid_plus/view/screen/income/income_screen.dart';
import 'package:resid_plus/view/screen/my_residence/my_residence_controller/my_residence_controller.dart';
import 'package:resid_plus/view/screen/my_residence/my_residence_repo/my_residence_repo.dart';
import 'package:resid_plus/view/screen/my_residence/my_residence_screen.dart';
import 'package:resid_plus/view/screen/profile/profile_controller/profile_controller.dart';
import 'package:resid_plus/view/screen/profile/profile_repo/profile_repo.dart';
import 'package:resid_plus/view/screen/settings/settings_screen.dart';
import 'package:resid_plus/view/screen/support/support_screen.dart';
import 'package:resid_plus/view/screen/wallet/wallet_screen.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Subscription/subscription_screen.dart';
import '../../residence_promotion/residence_promotion_screen.dart';

class HomeScreenDrawer extends StatefulWidget {
  const HomeScreenDrawer({super.key});

  @override
  State<HomeScreenDrawer> createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {
  @override
  void initState() {
    Get.put(MyResidenceRepo(apiService: Get.find()));
    var myResidenceController =
        Get.put(MyResidenceController(myResidenceRepo: Get.find()));
    DeviceUtils.bottomNavUtils();

    Get.put(ProfileRepo(apiService: Get.find()));

    final profileController =
        Get.put(ProfileController(profileRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileController.profile();
      myResidenceController.myResidence(search: "");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFF787878), Color(0xFF434343), Colors.black],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetBuilder<ProfileController>(builder: (controller) {
              if (controller.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.blackPrimary,
                  ),
                );
              }
              var data = controller.profileModel.data!.attributes!.user!;
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: ShapeDecoration(
                      image: data.image?.publicFileUrl != null
                          ? DecorationImage(
                              image:
                                  NetworkImage(data.image?.publicFileUrl ?? ""),
                              fit: BoxFit.fill,
                            )
                          : const DecorationImage(
                              image: AssetImage(
                                  "assets/images/profile_images.png"),
                              fit: BoxFit.fill,
                            ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.fullName ?? "---",
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.phoneNumber ?? "---",
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.40,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 16),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.height,
                color: Colors.white),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Get.to(() => const MyResidenceScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/my_resid.svg"),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Text(
                        'myResindence'.tr,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Get.to(() => AddUpdateResidence(
                    title: "addResidence".tr, isUpdate: false, id: ""));
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/add_residence.svg"),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Text(
                        'addResidence'.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Get.to(() => const BookingRequestScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcons.bookingRequest),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Text(
                        'bookingReq'.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Get.to(() => const IncomeScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Container(
                      height: 16,
                      width: 16,
                      alignment: Alignment.center,
                      padding: const EdgeInsetsDirectional.all(1.5),
                      decoration: BoxDecoration(
                          color: AppColors.transparentColor,
                          border:
                              Border.all(color: AppColors.whiteColor, width: 1),
                          shape: BoxShape.circle),
                      child: Text(
                        "\$",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                            color: AppColors.whiteColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'income'.tr,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Get.to(() => const SubscriptionScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.crownOutline,
                      height: 18,
                      width: 18,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'My Subscription'.tr,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Get.to(() => const SubscriptionScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.crownOutline,
                      height: 18,
                      width: 18,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Host Subscription'.tr,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Get.to(() => const ResidencePromotionScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.crownOutline,
                      height: 18,
                      width: 18,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Residence Subscription'.tr,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Get.to(() => const WalletScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/wallet.svg"),
                    const SizedBox(width: 16),
                    Text(
                      'Wallet'.tr,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.height,
                color: Colors.white),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Get.to(() => const SettingsScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/settings.svg"),
                    const SizedBox(width: 16),
                    Text(
                      'setting'.tr,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Get.to(() => const SupportScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/support.svg"),
                    const SizedBox(width: 16),
                    Text(
                      'support'.tr,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                Get.to(() => const AboutUsScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/about_us.svg"),
                    const SizedBox(width: 16),
                    Flexible(
                      child: Text(
                        'aboutUs'.tr,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.raleway(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
                height: 1,
                width: MediaQuery.of(context).size.height,
                color: Colors.white),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                          backgroundColor: Colors.white,
                          insetPadding:
                              const EdgeInsets.only(left: 20, right: 20),
                          child: SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsetsDirectional.symmetric(
                                  horizontal: 8, vertical: 24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "logOutAlert".tr,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF333333),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: CustomElevatedButton(
                                          isGradient: false,
                                          buttonHeight: 48,
                                          buttonWidth:
                                              MediaQuery.of(context).size.width,
                                          buttonColor: AppColors.whiteColor,
                                          onPressed: () async {
                                            final SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            // Remove data for the 'counter' key.
                                            await prefs.remove('counter');
                                            await prefs.remove(
                                                SharedPreferenceHelper
                                                    .userIdKey);
                                            Get.offAllNamed(
                                                AppRoute.signInScreen);
                                            Utils.toastMessage(
                                                "Log out Successfully".tr);
                                          },
                                          titleText: "Yes".tr,
                                          titleColor: AppColors.blackPrimary,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: CustomElevatedButton(
                                            buttonHeight: 48,
                                            buttonWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            buttonColor: AppColors.blackPrimary,
                                            onPressed: () => Get.back(),
                                            titleText: "No".tr),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/logout.svg"),
                    const SizedBox(width: 16),
                    Text(
                      'logOut'.tr,
                      style: GoogleFonts.raleway(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
