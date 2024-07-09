import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/settings/languages_change/lang_controller/language_controller.dart';
import 'package:resid_plus/view/widgets/text/custom_text.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {

  final prefs = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
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
                      "Languages".tr,
                      style: GoogleFonts.raleway(
                        color: AppColors.blackPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            )),
        backgroundColor: AppColors.bgColor,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) =>
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 24,left: 20,bottom: 100,right: 20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.updateLocale(const Locale("en", "US"));
                        Get.find<LanguageController>().toggleLanguage();
                        Utils.toastMessage("Language Changed Successfully");
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        decoration: ShapeDecoration(
                          color: AppColors.whiteColor,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.50, color: AppColors.blackPrimary),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                          child: CustomText(
                            text: "English",
                            color: AppColors.blackPrimary,
                            left: 10,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        Get.updateLocale(const Locale("fr" , "CA"));
                        Get.find<LanguageController>().toggleLanguage();
                        Utils.toastMessage("La langue a changé avec succès".tr);
                      } ,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.centerLeft,
                        decoration: ShapeDecoration(
                          color: AppColors.whiteColor,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.50, color: AppColors.blackPrimary),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                          child: CustomText(
                            text: "French",
                            color: AppColors.blackPrimary,
                            left: 10,
                          ),
                        ),
                      ),
                    )
                  ]
                ),
              ),
        ),
      )
    );
  }
}