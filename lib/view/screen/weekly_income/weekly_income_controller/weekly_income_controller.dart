import 'dart:convert';

import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/view/screen/weekly_income/weekly_income_model/weekly_income_model.dart';
import 'package:resid_plus/view/screen/weekly_income/weekly_income_repo/weekly_income_repo.dart';

class WeeklyIncomeController extends GetxController {

  WeeklyIncomeRepo weeklyIncomeRepo ;

  WeeklyIncomeController({required this.weeklyIncomeRepo});
  WeeklyIncomeModel weeklyIncomeModel = WeeklyIncomeModel();
  List <AllPayment> incomeList = [];
  bool isLoading =  true;
  Future<void> getWeeklyIncomeData ()async {
    ApiResponseModel responseModel = await weeklyIncomeRepo.weeklyIncomeResponse();

    if( responseModel.statusCode == 200){

     weeklyIncomeModel = WeeklyIncomeModel.fromJson(jsonDecode(responseModel.responseJson));
     isLoading = false;
     update();
      List <AllPayment>? tempList =  weeklyIncomeModel.data?.allPayments;
      if(tempList!=null && tempList.isNotEmpty){
       incomeList.addAll(tempList);
       }

     print("${"this is weeeklyResponse model "} $weeklyIncomeModel");
    }
    isLoading = false;
    update();
  }
  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //    getWeeklyIncomeData();
  //   super.onInit();
  // }
}