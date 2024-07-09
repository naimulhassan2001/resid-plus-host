import 'dart:convert';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/view/screen/income/income_model/income_model.dart';
import 'package:resid_plus/view/screen/income/incone_repo/incone_repo.dart';

class IncomeController extends GetxController {
  IncomeRepo incomeRepo;
  IncomeController({required this.incomeRepo});

  IncomeModel supportModel = IncomeModel();

  bool isLoading = false;
  String income = "";

  Future<void> getIncome() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await incomeRepo.supportResponse();
    print("status code: ${responseModel.statusCode}");


    if (responseModel.statusCode == 200) {
      supportModel = IncomeModel.fromJson(jsonDecode(responseModel.responseJson));
      income = supportModel.data ?? "";
    } else {

    }


    isLoading = false;
    update();
  }

  @override
  void onInit() {
    getIncome();
    super.onInit();
  }
}
