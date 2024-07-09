import 'dart:convert';

import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/view/screen/daily_income/daily_income_model/daily_income_model.dart';
import 'package:resid_plus/view/screen/daily_income/daily_income_repo/daily_income_repo.dart';

class DailyIncomeController extends GetxController{

  DailyIncomeRepo dailyIncomeRepo;

  DailyIncomeController({required this.dailyIncomeRepo});

  DailyIncomeModel dailyIncomeModel = DailyIncomeModel();

  List<AllPayment> incomeData =  [];

 bool isLoading = true;

 Future<void> getDailyIncomeDat() async {

   ApiResponseModel responseModel = await dailyIncomeRepo.dailyIncomeResponse();
   if(responseModel.statusCode==200){
       dailyIncomeModel = DailyIncomeModel.fromJson(jsonDecode(responseModel.responseJson));

       List<AllPayment>? tempList =  dailyIncomeModel.data?.allPayments;

       if(tempList !=null && tempList.isEmpty){
         incomeData.addAll(tempList);
       }

       isLoading = false;
       update();

   }
   isLoading = false;
   update();
 }

}