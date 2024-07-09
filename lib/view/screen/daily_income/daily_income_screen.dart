import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/core/helper/date_converter_helper.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/daily_income/daily_income_controller/daily_income_controller.dart';
import 'package:resid_plus/view/screen/daily_income/daily_income_repo/daily_income_repo.dart';
import 'package:resid_plus/view/widgets/app_bar/custom_app_bar.dart';

class DailyIncomeScreen extends StatefulWidget {
  const DailyIncomeScreen({super.key});

  @override
  State<DailyIncomeScreen> createState() => _DailyIncomeScreenState();
}

class _DailyIncomeScreenState extends State<DailyIncomeScreen> {
  @override
  void initState() {
    DeviceUtils.innerUtils();

      Get.put(ApiService(sharedPreferences: Get.find()));
      Get.put(DailyIncomeRepo(apiService: Get.find()));
      final controller = Get.put(DailyIncomeController(dailyIncomeRepo: Get.find()));
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        controller.getDailyIncomeDat();
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
                  "Daily Income".tr,
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
        body: GetBuilder<DailyIncomeController>(
          builder: (controller) {

            return  controller.isLoading ?
            const Center(child: CircularProgressIndicator(color: AppColors.blackPrimary,),) : controller.incomeData.isEmpty ? Center(
              child: Text(
                  "No Data Found".tr,
                  style: const TextStyle(fontSize: 20))
            ): SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 20, vertical: 24),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: List.generate(
                    controller.dailyIncomeModel.data!.allPayments!.length,
                    (index) => Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsetsDirectional.only(bottom: 8),
                          decoration: BoxDecoration(
                              color: AppColors.transparentColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 0.5, color: const Color(0xFF818181))),
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
                                            image: NetworkImage(controller.dailyIncomeModel.data!.allPayments![index].residenceId!.photo![0].publicFileUrl.toString()),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius: BorderRadius.circular(8)),
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                         controller.dailyIncomeModel.data!.allPayments![index].residenceId!.residenceName ?? "",
                                          style: GoogleFonts.raleway(
                                            color: AppColors.blackPrimary,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            const Icon(
                                                Icons.calendar_month_outlined,
                                                size: 18,
                                                color: AppColors.black40),
                                            const SizedBox(width: 4),
                                            Text(
                                              "${DateConverter.dateAndMonth(controller.dailyIncomeModel.data!.allPayments![index].bookingId!.checkInTime.toString())}-${DateConverter.dateAndMonth(controller.dailyIncomeModel.data!.allPayments![index].bookingId!.checkOutTime.toString())}",
                                              style: GoogleFonts.openSans(
                                                color: AppColors.black40,
                                                fontSize: 16,
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
                              Text(
                               "${controller.dailyIncomeModel.data!.allPayments![index].bookingId!.totalAmount.toString() ??"00"}${" FCFA"}"
                               , style: GoogleFonts.openSans(
                                  color: AppColors.blackPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        )),
              ),
            );
          }
        ),
      ),
    );
  }
}
