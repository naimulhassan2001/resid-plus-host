import 'dart:convert';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/view/screen/wallet/wallet_controller/wallet_repo.dart';
import 'package:resid_plus/view/screen/wallet/wallet_controller/wallet_model.dart';

class WalletController extends GetxController{
WalletRepo walletRepo;
WalletController({required this.walletRepo});


WalletModel walletModel = WalletModel();

bool isLoading = false;
var income;

getWalletData()async{
  isLoading = true;
  update();
  ApiResponseModel responseModel = await walletRepo.walletResponse();
  if (responseModel.statusCode == 200) {
    walletModel = WalletModel.fromJson(jsonDecode(responseModel.responseJson));
    income = walletModel.data?.attributes;
  }
  isLoading = false;
  update();
}

@override
void onInit() {
  getWalletData();
  super.onInit();
}
}