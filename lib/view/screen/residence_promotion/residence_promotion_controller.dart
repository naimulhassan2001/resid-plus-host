import 'dart:convert';

import 'package:get/get.dart';
import 'package:resid_plus/service/rest_api_service.dart';
import 'package:resid_plus/view/screen/residence_promotion/my_residence_model.dart';
import '../../../core/global/api_url_container.dart';
import '../../../utils/app_utils.dart';
import '../payment/payment_method_screen.dart';

class ResidencePromotionController extends GetxController {
  bool isLoading = false;
  bool isLoadingResidence = false;

  String selectResidence = '';

  List promotions = [];
  List myResidence = [];

  getPromotionResidencesRepo() async {
    isLoading = true;
    update();

    var response = await ApiServiceRest.getApi(
        "${ApiUrlContainer.baseUrl}${ApiUrlContainer.promotion}");

    if (response.statusCode == 200) {
      List? data = jsonDecode(response.responseJson)['data']['attributes']
          ['promoteResidenceList'];
      if (data != null && data.isNotEmpty) {
        promotions.addAll(data);
      }
      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
      Utils.snackBar(response.statusCode.toString(), response.message);
    }
  }

  getPaymentToken({required String id, required String amount}) async {
    isLoadingResidence = true;
    update();

    var body = {
      "subsriptionId": id,
      "subscriptionType": "Residence",
      "amount": amount
    };

    var response = await ApiServiceRest.postApi(
        '${ApiUrlContainer.baseUrl}${ApiUrlContainer.getPaymentToken}', body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.responseJson);
      Get.to(PaymentMethodScreen(
        paymentId: data['data']['attributes']['_id'],
        token: data['data']['attributes']['token'],
      ));
    }

    isLoadingResidence = false;
    update();
  }

  Future getMyResidenceRepo() async {
    isLoadingResidence = true;
    update();

    var response = await ApiServiceRest.getApi(
        '${ApiUrlContainer.baseUrl}${ApiUrlContainer.allResidenceEndPoint}');

    if (response.statusCode == 200) {
      List data = jsonDecode(response.responseJson)['data']['attributes']
              ['residences'] ??
          [];

      myResidence.clear();
      for (var item in data) {
        myResidence.add(MyResidence.fromJson(item));
      }
    }

    isLoadingResidence = false;
    update();
  }

  static ResidencePromotionController get instance =>
      Get.put(ResidencePromotionController());

  @override
  void onInit() {
    getPromotionResidencesRepo();
    super.onInit();
  }
}
