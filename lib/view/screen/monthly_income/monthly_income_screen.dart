import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_icons.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/monthly_income/monthly_income_controller/monthly_income_controller.dart';
import 'package:resid_plus/view/widgets/app_bar/custom_app_bar.dart';

class MonthlyIncomeScreen extends StatefulWidget {
  const MonthlyIncomeScreen({super.key});

  @override
  State<MonthlyIncomeScreen> createState() => _MonthlyIncomeScreenState();
}

class _MonthlyIncomeScreenState extends State<MonthlyIncomeScreen> {
  @override
  void initState() {
    Get.put(MonthlyIncomeController());
    DeviceUtils.innerUtils();
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.innerUtils();
    super.dispose();
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
                    "Monthly Income".tr,
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
          body: GetBuilder<MonthlyIncomeController>(builder: (controller) {


            return controller.isLoading ? const Center(
              child: CircularProgressIndicator(color: AppColors.blackPrimary),
            ) : controller.monthAndAmmountValueList.isEmpty ?  Center(
                child: Text(
                    "No Data Found".tr,
                    style: const TextStyle(fontSize: 20))
            ) : SingleChildScrollView(
                    padding: const EdgeInsetsDirectional.only(
                        start: 20, end: 20, bottom: 24),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                            controller.monthAndAmmountValueList.length,
                            (index) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsetsDirectional.only(bottom: 8),
                            decoration: BoxDecoration(
                                color: AppColors.transparentColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 0.5,
                                    color: const Color(0xFF818181))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              begin: Alignment(-0.00, -1.00),
                                              end: Alignment(0, 1),
                                              colors: [
                                                Color(0xFF787878),
                                                Color(0xFF434343),
                                                Colors.black
                                              ],
                                            ),
                                            image: const DecorationImage(
                                              image:
                                                  AssetImage(AppIcons.moneyBag),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.monthAndAmmountValueList[
                                                index]["date"],
                                            style: GoogleFonts.openSans(
                                              color: AppColors.black60,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Text(
                                                controller
                                                    .monthAndAmmountValueList[
                                                        index]["amount"]
                                                    .toString(),
                                                style: GoogleFonts.openSans(
                                                  color: AppColors.blackPrimary,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                ' FCFA',
                                                style: GoogleFonts.raleway(
                                                  color: AppColors.blackPrimary,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList()));
          })),
    );
  }
}
