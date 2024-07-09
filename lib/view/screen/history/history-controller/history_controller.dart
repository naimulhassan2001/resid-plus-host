import 'dart:convert';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/history/history_model/history_model.dart';
import 'package:resid_plus/view/screen/history/history_repo/history_repo.dart';

class HistoryController extends GetxController{

  HistoryRepo historyRepo;
  HistoryController({required this.historyRepo});

  bool isLoading = false;

  List<Booking> historyList = [];

  @override
  void onInit() {
    getHistoryData();
    super.onInit();
  }

  HistoryModel historyModel = HistoryModel();
  Future<void> getHistoryData()async {

    isLoading = true;
    update();

    ApiResponseModel responseModel = await historyRepo.historyResponse();

    if(responseModel.statusCode == 200){

      historyModel = HistoryModel.fromJson(jsonDecode(responseModel.responseJson));

      List<Booking> ? tempList = historyModel.data?.attributes?.bookings;


      if(tempList!=null && tempList.isNotEmpty){
        // historyList = [];
        historyList.addAll(tempList);


    }

    }
    else{
      Utils.toastMessageCenter(responseModel.message);

    }
    isLoading = false;
    update();
  }

  void deleteHistory({required String id, }) async{

    ApiResponseModel responseModel = await historyRepo.deleteHistory(id: id);

    if(responseModel.statusCode == 200){
     Utils.toastMessage(responseModel.message);
     getHistoryData();
     update();
    }
  }
}