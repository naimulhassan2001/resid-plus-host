import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/booking_details/inner_widget/booking_details_booking_info_section.dart';
import 'package:resid_plus/view/screen/booking_details/inner_widget/booking_details_top_section.dart';
import 'package:resid_plus/view/screen/booking_details/inner_widget/booking_details_user_info.dart';
import 'package:resid_plus/view/screen/booking_list/booking_list_model/booking_list_model.dart';
import 'package:resid_plus/view/widgets/app_bar/custom_app_bar.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  @override
  void initState() {
    DeviceUtils.innerUtils();
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.bottomNavUtils();
    super.dispose();
  }

  BookingListModel bookingListModel = Get.arguments[0];
  int index = Get.arguments[1];

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
                "Booking Details".tr,
                style: GoogleFonts.raleway(
                  color: AppColors.blackPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        )),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Hotel Info

              BookingDetailsTopSection(
                bookingListModel: bookingListModel,
                index: index,
              ),
              const SizedBox(height: 24),

              //Booking Info

              BookingDetailsBookingInfoSection(
                  index: index, bookingListModel: bookingListModel),
              const SizedBox(height: 24),

              //User Info

              BookingDetailsUserInfo(
                index: index,
                bookingListModel: bookingListModel,
              )
            ],
          ),
        ),
      ),
    );
  }
}
