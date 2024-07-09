import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/view/screen/weekly_income/weekly_income_controller/weekly_income_controller.dart';
import 'package:resid_plus/view/screen/weekly_income/weekly_income_repo/weekly_income_repo.dart';

class WeeklyIncomeTopSection extends StatefulWidget {

  const WeeklyIncomeTopSection({super.key});

  @override
  State<WeeklyIncomeTopSection> createState() => _WeeklyIncomeTopSectionState();
}

class _WeeklyIncomeTopSectionState extends State<WeeklyIncomeTopSection> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(WeeklyIncomeRepo(apiService: Get.find()));
    final controller = Get.put(WeeklyIncomeController(weeklyIncomeRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getWeeklyIncomeData();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return GetBuilder<WeeklyIncomeController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Week'.tr,
              style: GoogleFonts.raleway(
                color: AppColors.blackPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 24, left: 24, bottom: 24),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF787878), Color(0xFF434343), Colors.black],
                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Week no. '.tr,
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: controller.weeklyIncomeModel.data!.weekNumber.toString() ??"",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: controller.weeklyIncomeModel.data!.total.toString() ?? "",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: ' FCFA',
                          style: GoogleFonts.raleway(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }
    );
  }
}
