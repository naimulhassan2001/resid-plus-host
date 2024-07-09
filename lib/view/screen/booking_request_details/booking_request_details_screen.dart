import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/booking_list/booking_list.dart';
import 'package:resid_plus/view/screen/booking_request/booking_req_controller/booking_req_controller.dart';
import 'package:resid_plus/view/screen/booking_request_details/booking_req_repo/booking_req_repo.dart';
import 'package:resid_plus/view/screen/booking_request_details/inner_widget/booking_request_booking_info_section.dart';
import 'package:resid_plus/view/screen/booking_request_details/inner_widget/booking_request_top_section.dart';
import 'package:resid_plus/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_button.dart';

class BookingRequestDetailsScreen extends StatefulWidget {
  const BookingRequestDetailsScreen({super.key});

  @override
  State<BookingRequestDetailsScreen> createState() =>
      _BookingRequestDetailsScreenState();
}

class _BookingRequestDetailsScreenState
    extends State<BookingRequestDetailsScreen> {
  @override
  void initState() {
    DeviceUtils.innerUtils();
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.innerUtils();
    super.dispose();
  }

  final bookingDetailsModel = Get.arguments[0];
  int index = Get.arguments[1];

  BookingReqRepo bookingReqRepo = BookingReqRepo(apiService: Get.find());
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
              Flexible(
                child: Text(
                  "Booking Request Details".tr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,


                  style: GoogleFonts.raleway(
                    color: AppColors.blackPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        )),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 20, vertical: 24),
            child: GetBuilder<BookingReqController>(
              builder: (controller) => controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: AppColors.blackPrimary,),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BookingCancelTopSection(),
                        const SizedBox(height: 24),
                        const BookingInfo(),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomElevatedButton(
                                isGradient: false,
                                buttonHeight: 48,
                                borderColor: AppColors.blackPrimary,
                                buttonColor: AppColors.transparentColor,
                                titleColor: AppColors.blackPrimary,
                                buttonWidth: MediaQuery.of(context).size.width,
                                titleText: "Cancel".tr,
                                onPressed: () {
                                  bookingReqRepo.bookingRequestResponse(
                                      request: Request.cancelled,
                                      id: bookingDetailsModel[index].id.toString());
                                  controller.getBookingReqData();
                                  navigator!.pop();
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: CustomElevatedButton(
                                  buttonHeight: 48,
                                  buttonWidth:
                                      MediaQuery.of(context).size.width,
                                  onPressed: () {
                                    bookingReqRepo.bookingRequestResponse(
                                        request: Request.reserved,
                                        id: bookingDetailsModel[index].id.toString());
                                    controller.getBookingReqData();
                                    navigator!.push(MaterialPageRoute(
                                        builder: (_) => const BookingList()));
                                  },
                                  titleText: "Approve".tr),
                            ),
                          ],
                        ),
                        /*BookingCancelHostInfo()*/
                      ],
                    ),
            )),
      ),
    );
  }
}
