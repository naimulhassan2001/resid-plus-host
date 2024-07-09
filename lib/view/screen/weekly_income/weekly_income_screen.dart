import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/weekly_income/inner_widget/weekly_income_bottom_section.dart';
import 'package:resid_plus/view/screen/weekly_income/inner_widget/weekly_income_top_section.dart';
import 'package:resid_plus/view/screen/weekly_income/weekly_income_controller/weekly_income_controller.dart';
import 'package:resid_plus/view/screen/weekly_income/weekly_income_repo/weekly_income_repo.dart';
import 'package:resid_plus/view/widgets/app_bar/custom_app_bar.dart';

class WeeklyIncomeScreen extends StatefulWidget {

  const WeeklyIncomeScreen({super.key});

  @override
  State<WeeklyIncomeScreen> createState() => _WeeklyIncomeScreenState();
}

class _WeeklyIncomeScreenState extends State<WeeklyIncomeScreen> {

  @override
  void initState() {
    DeviceUtils.innerUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(WeeklyIncomeRepo(apiService: Get.find()));
    final controller = Get.put(WeeklyIncomeController(weeklyIncomeRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getWeeklyIncomeData();
      }
    );
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
                const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18),
                const SizedBox(width: 8),
                Text(
                  "Weekly Income".tr,
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
        body:    Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 24),
          child: GetBuilder<WeeklyIncomeController>(builder: (controller){
            return controller.isLoading ? const Center(
              child: CircularProgressIndicator(color: AppColors.blackPrimary),
            ) : controller.incomeList.isEmpty ?  Center(
                child: Text(
                    "No Data Found".tr,
                    style: const TextStyle(fontSize: 20))
            ) : const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WeeklyIncomeTopSection(),
                SizedBox(height: 24),
                Expanded(child: WeeklyIncomeBottomSection())
              ],
            );
          }),
        ),
      ),
    );
  }
}
