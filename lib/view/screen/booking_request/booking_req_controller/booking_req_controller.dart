import 'dart:convert';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/view/screen/booking_request/booking_req_model/booking_request_model.dart';
import 'package:resid_plus/view/screen/booking_request/booking_req_repo/booking_req-repo.dart';

class BookingReqController extends GetxController {
  BookingRequestRepo bookingRequestRepo;
  BookingReqController({required this.bookingRequestRepo});

  bool isLoading = true;

  BookingRequestModel bookingRequestModel = BookingRequestModel();

  List<Bookings> bookingList = [];

  Future<void> getBookingReqData() async {

    ApiResponseModel responseModel = await bookingRequestRepo.bookingReqResponse();

    print("status code: ${responseModel.statusCode}");
    if (responseModel.statusCode == 200) {
      bookingList.clear();
      bookingRequestModel =
       BookingRequestModel.fromJson(jsonDecode(responseModel.responseJson));
       List<Bookings> ?tempList = bookingRequestModel.data?.attributes?.bookings;
       if(tempList!=null&&tempList.isNotEmpty){
         bookingList.addAll(tempList);
       }

      isLoading = false;
      update();
    } else {
      print("status code: ${responseModel.statusCode}");
    }
    isLoading = false;
    update();
  }

  //
  @override
  void onInit() {
    getBookingReqData();
    super.onInit();
  }
}
