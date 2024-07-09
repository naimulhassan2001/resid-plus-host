import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_icons.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/add_residence/add_update_residence_screen.dart';
import 'package:resid_plus/view/screen/my_residence/my_residence_controller/my_residence_controller.dart';
import 'package:resid_plus/view/screen/my_residence/my_residence_repo/my_residence_repo.dart';
import 'package:resid_plus/view/screen/profile/profile_controller/profile_controller.dart';
import 'package:resid_plus/view/screen/profile/profile_repo/profile_repo.dart';

class HomeScreenInitialData extends StatefulWidget {
  const HomeScreenInitialData({super.key});

  @override
  State<HomeScreenInitialData> createState() => _HomeScreenInitialDataState();
}

class _HomeScreenInitialDataState extends State<HomeScreenInitialData> {
  @override
  void initState() {
    DeviceUtils.bottomNavUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));

    Get.put(ProfileRepo(apiService: Get.find()));

    final profileController =
        Get.put(ProfileController(profileRepo: Get.find()));

    Get.put(MyResidenceRepo(apiService: Get.find()));

    final controller =
        Get.put(MyResidenceController(myResidenceRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileController.profile();
      controller.myResidence(search: "");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.addNewResidenceIcon),
            const SizedBox(height: 24),
            InkWell(
              onTap: () => Get.to(() =>  AddUpdateResidence(
                    title: "addResidence".tr,
                    isUpdate: false,
                    id: "",
                  )),
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 12, vertical: 6),
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_circle_outline_rounded,
                          color: AppColors.blackPrimary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                         // "Add New Residence".tr,
                        "newResidence".tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                            color: AppColors.blackPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
