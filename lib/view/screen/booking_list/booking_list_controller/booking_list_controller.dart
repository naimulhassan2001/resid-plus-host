import 'dart:convert';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/booking_list/booking_list_model/booking_list_model.dart';
import 'package:resid_plus/view/screen/booking_list/booking_list_repo/booking_list_repo.dart';

class BookingListController extends GetxController {
  BookingListRepo bookingListRepo;
  BookingListController({required this.bookingListRepo});

  BookingListModel bookingListModel = BookingListModel();
  bool isLoading = false;
  List<Booking> bookingInfo = [];

  Future<void> bookingList() async {
    isLoading = true;
    update();

    ApiResponseModel responseModel = await bookingListRepo.bookingList();

    if (responseModel.statusCode == 200) {
      bookingListModel =
          BookingListModel.fromJson(jsonDecode(responseModel.responseJson));
            List<Booking>? bI = bookingListModel.data!.attributes!.bookings;
      bookingInfo = [];
      bookingInfo.addAll(bI!);
      isLoading = false;
      update();
    } else {
      Utils.toastMessageCenter(responseModel.message);
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    bookingList();
    super.onInit();
  }
}
