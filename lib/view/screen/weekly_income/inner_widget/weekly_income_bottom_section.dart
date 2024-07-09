import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/core/helper/date_converter_helper.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/view/screen/weekly_income/weekly_income_controller/weekly_income_controller.dart';
import 'package:resid_plus/view/screen/weekly_income/weekly_income_repo/weekly_income_repo.dart';

class WeeklyIncomeBottomSection extends StatefulWidget {
  const WeeklyIncomeBottomSection({super.key});

  @override
  State<WeeklyIncomeBottomSection> createState() => _WeeklyIncomeBottomSectionState();

}
class _WeeklyIncomeBottomSectionState extends State<WeeklyIncomeBottomSection> {

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

    return GetBuilder<WeeklyIncomeController>(builder: (controller){
      // if(controller.isLoading == true){
      //   return const Center(child: CircularProgressIndicator(),);
      // }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Past Weekly Income'.tr,
            style: GoogleFonts.raleway(
              color: AppColors.blackPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.blackPrimary, height: 1),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(controller.weeklyIncomeModel.data!.allPayments!.length, (index) =>  Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsetsDirectional.only(bottom: 8),
                  decoration: BoxDecoration(
                      color: AppColors.transparentColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 0.5, color: const Color(0xFF818181))
                  ),
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
                                  image:  DecorationImage(
                                    image: CachedNetworkImageProvider(controller.incomeList[index].residenceId!.photo![0].publicFileUrl.toString()),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.incomeList[index].residenceId!.residenceName ?? "",
                                    style: GoogleFonts.raleway(
                                      color: AppColors.blackPrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_month_outlined, size: 18, color: AppColors.black40),
                                      const SizedBox(width: 4),
                                      Text(
                                    "${DateConverter.dateAndMonth(controller.incomeList[index].bookingId!.checkInTime.toString())}-${DateConverter.dateAndMonth(controller.incomeList[index].bookingId!.checkOutTime.toString())}",
                                        style: GoogleFonts.openSans(
                                          color: AppColors.black40,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "${controller.incomeList[index].bookingId!.totalAmount.toString() ??"00"}${" FCFA"}",
                        style: GoogleFonts.openSans(
                          color: AppColors.blackPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                )),
              ),
            ),
          )
        ],
      );
    });
  }
}
