import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/core/helper/date_converter_helper.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/booking_request/booking_req_controller/booking_req_controller.dart';
import 'package:resid_plus/view/screen/booking_request/booking_req_repo/booking_req-repo.dart';
import 'package:resid_plus/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_button.dart';

class BookingRequestScreen extends StatefulWidget {
  const BookingRequestScreen({super.key});

  @override
  State<BookingRequestScreen> createState() => _BookingRequestScreenState();
}

class _BookingRequestScreenState extends State<BookingRequestScreen> {
  @override
  void initState() {
    DeviceUtils.innerUtils();

    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(BookingRequestRepo(apiService: Get.find()));
    final controller =
        Get.put(BookingReqController(bookingRequestRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getBookingReqData();
    });
    super.initState();
  }

  @override
  void deactivate() {
    DeviceUtils.bottomNavUtils();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: CustomAppBar(
              appBarContent: GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              children: [
                const Icon(Icons.arrow_back_ios,
                    color: AppColors.blackPrimary, size: 18),
                const SizedBox(width: 8),
                Text(
                  "bookingReq".tr,
                  style: GoogleFonts.raleway(
                    color: const Color(0xFF333333),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )),
          body: GetBuilder<BookingReqController>(
            builder: (controller) {

              return LayoutBuilder(
                builder: (context, BoxConstraints constraints) => controller.isLoading ? const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.blackPrimary
                    )
                ) : controller.bookingList.isNotEmpty ? SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.only(
                      bottom: 24, start: 20, end: 20),
                  physics: const BouncingScrollPhysics(),
                      child:   Column(
                    children: List.generate(
                    controller.bookingList.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: GestureDetector(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 230,
                                  padding: const EdgeInsetsDirectional.only(
                                      top: 8, end: 8),
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(controller.bookingList[index].residenceId?.photo![0].publicFileUrl ?? ""),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              controller.bookingList[index].residenceId?.residenceName ?? "",
                                              style: GoogleFonts.raleway(
                                                color: const Color(0xFF333333),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Row(
                                              children: [
                                                const Icon(Icons.star,
                                                    color: Color(0xFFFBA91D),
                                                    size: 18),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  "${controller.bookingList[index].residenceId?.ratings ?? ""}"
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/icons/location.svg"),
                                            const SizedBox(width: 4),
                                            Text(
                                              controller.bookingList[index].residenceId?.address ?? "",
                                              style: GoogleFonts.raleway(
                                                color: const Color(0xFF818181),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                    Icons.calendar_month_outlined,
                                                    size: 18,
                                                    color: AppColors.black40),
                                                const SizedBox(width: 4),
                                                Text(
                                                  "${DateConverter.isoStringToLocalFormattedDateOnly(controller.bookingList[index].checkInTime ?? "--")} - ${DateConverter.isoStringToLocalFormattedDateOnly(controller.bookingList[index].checkOutTime ?? "---")}",
                                                  style: GoogleFonts.raleway(
                                                    color:
                                                    const Color(0xFF818181),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'FCFA ',
                                                    style: GoogleFonts.raleway(
                                                      color:
                                                      const Color(0xFF333333),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: "${controller.bookingList[index].totalAmount ?? ""}",
                                                    style: GoogleFonts.openSans(
                                                      color:
                                                      const Color(0xFF333333),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              textAlign: TextAlign.right,
                                            )
                                          ],
                                        )
                                      ],
                                    )),
                                const SizedBox(height: 16),
                                CustomElevatedButton(
                                    buttonHeight: 48,
                                    buttonWidth:
                                    MediaQuery.of(context).size.width,
                                    onPressed: () => Get.toNamed(
                                        AppRoute.bookingRequestDetailsScreen,
                                        arguments: [
                                          controller.bookingList,
                                          index
                                        ]),
                                    titleText: "See Details".tr),
                                const SizedBox(height: 24),
                                index ==
                                    (controller.bookingList.length - 1)
                                    ? const SizedBox()
                                    : const Divider(
                                    color: AppColors.blackPrimary,
                                    height: 1,
                                    thickness: 1)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ) :
                 Center(child: Text("No Data Found".tr,style: const TextStyle(fontSize: 20),),)
              );
            }
          ),
        ));
  }
}
