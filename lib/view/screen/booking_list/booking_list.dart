import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/core/helper/date_converter_helper.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/booking_list/booking_list_controller/booking_list_controller.dart';
import 'package:resid_plus/view/screen/booking_list/booking_list_repo/booking_list_repo.dart';
import 'package:resid_plus/view/widgets/bottom_nav/custom_bottom_nav_bar.dart';

class BookingList extends StatefulWidget {
  const BookingList({super.key});

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(BookingListRepo(apiService: Get.find()));
    final controller =
        Get.put(BookingListController(bookingListRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.bookingList();
    });

    DeviceUtils.bottomNavUtils();
    super.initState();
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
                "Booking List".tr,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
        body: GetBuilder<BookingListController>(builder: (controller) {
          if (controller.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.blackPrimary,),
            );
          }

          return controller.bookingInfo.isNotEmpty
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 24, horizontal: 20),
                  child: Column(
                    children: List.generate(controller.bookingListModel.data!.attributes!.bookings!.length, (index) {
                      var data = controller.bookingListModel.data!.attributes!.bookings![index];
                      return GestureDetector(
                        onTap: () => Get.toNamed(AppRoute.bookingDetails,
                            arguments: [controller.bookingListModel, index]),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsetsDirectional.only(bottom: 8),
                          decoration: BoxDecoration(
                              color: AppColors.transparentColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 0.5, color: const Color(0xFF818181))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: FittedBox(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(data
                                                .userId!.image!.publicFileUrl
                                                .toString()),
                                            fit: BoxFit.fill,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                data.residenceId!.residenceName.toString(),
                                                style: GoogleFonts.raleway(
                                                  color: AppColors.blackPrimary,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),

                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              const Icon(Icons.star, size: 18, color: Color(0xFFFBA91D)),
                                              const SizedBox(width: 4),
                                              Text(
                                                '(${data.residenceId!.ratings})',
                                                style: GoogleFonts.openSans(
                                                  color: AppColors.blackPrimary,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
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
                                                '${DateConverter.dateAndMonth(data.checkInTime.toString())} - ${DateConverter.dateAndMonth(data.checkOutTime.toString())}',
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
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 6),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF2E1E3),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  "${data.residenceId!.status}".toUpperCase(),
                                  style: GoogleFonts.raleway(
                                    color: const Color(0xFFD7263D),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ))
              :  Center(child: Text("No Data Found".tr,style: GoogleFonts.raleway(fontSize: 20)));
        }),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
      ),
    );
  }
}
