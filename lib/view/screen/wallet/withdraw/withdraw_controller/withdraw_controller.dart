import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/wallet/wallet_controller/wallet_controller.dart';
import 'package:resid_plus/view/screen/wallet/withdraw/withdraw_model/withdraw_model.dart';
import 'package:resid_plus/view/screen/wallet/withdraw/withdraw_repo/withdraw_repo.dart';
class WithdrawController extends GetxController {
  WithdrawRepo withdrawRepo;

  WithdrawController({required this.withdrawRepo});
  WalletController controller = Get.find<WalletController>();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String withdrawmode = "";

  WithDrawModel withDrawModel = WithDrawModel();


  Future<void> withdrawMoney() async {
    if (withdrawmode.isNotEmpty) {
      ApiResponseModel responseModel = await withdrawRepo.withdrawData(
          accountNo: cardNumberController.text.trim(),
          amount: amountController.text.trim(),
          withDrawMode: withdrawmode.trim());
      if (responseModel.statusCode == 201) {
        withDrawModel = WithDrawModel.fromJson(jsonDecode(responseModel.responseJson));
        Utils.toastMessage(responseModel.message);

        controller.getWalletData();
      }
      else if(responseModel.statusCode==400){
        Utils.toastMessage(responseModel.message);
      }
      else {
        Utils.toastMessage(responseModel.message);
      }
    }else {
      Utils.toastMessage("Select your payment method".tr);
    }
  }
}