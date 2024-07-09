import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/daily_income/daily_income_screen.dart';
import 'package:resid_plus/view/screen/income/income_controller/income_controller.dart';
import 'package:resid_plus/view/screen/income/incone_repo/incone_repo.dart';
import 'package:resid_plus/view/screen/income/inner_widget/income_card.dart';
import 'package:resid_plus/view/screen/income/inner_widget/income_screen_top_section.dart';
import 'package:resid_plus/view/screen/monthly_income/monthly_income_screen.dart';
import 'package:resid_plus/view/screen/weekly_income/weekly_income_screen.dart';
import 'package:resid_plus/view/widgets/app_bar/custom_app_bar.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  @override
  void initState() {
    DeviceUtils.innerUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(IncomeRepo(apiService: Get.find()));
    final controller = Get.put(IncomeController(incomeRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getIncome();
    });
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
      child: GetBuilder<IncomeController>(
        builder: (controller) {
          return Scaffold(
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
                      "income".tr,
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
            body: controller.isLoading ? const Center(child: CircularProgressIndicator( color: Colors.black)) : SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(
                  vertical: 24, horizontal: 20),
              physics: const BouncingScrollPhysics(),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const IncomeScreenTopSection(),
                    const SizedBox(height: 16),
                    IncomeCard(
                      title: "Daily Income".tr,
                      press: () => Get.to(() => const DailyIncomeScreen()),
                    ),
                    const SizedBox(height: 16),
                    IncomeCard(
                      title: "Weekly Income".tr,
                      press: () => Get.to(() => const WeeklyIncomeScreen()),
                    ),
                    const SizedBox(height: 16),
                    IncomeCard(
                      title: "Monthly Income".tr,
                      press: () => Get.to(() => const MonthlyIncomeScreen()),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
