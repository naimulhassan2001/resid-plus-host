import 'dart:convert';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/view/screen/settings/faq/faq_model/faq_model.dart';
import 'package:resid_plus/view/screen/settings/faq/faq_repo/faq_repo.dart';

class FaqController extends GetxController {
  FaqRepo faqRepo;
  FaqController({required this.faqRepo});

  FaqModel faqModel = FaqModel();
  bool isLoading = false;

  List<Attribute> attributes = [];

  Future<void> getFaqData() async {
    isLoading = true;
    update();

    ApiResponseModel responseModel = await faqRepo.faqResponse();


    if (responseModel.statusCode == 200) {
      faqModel = FaqModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Attribute>? temp = faqModel.data?.attributes;

      if(temp != null && temp.isNotEmpty){
        attributes.addAll(temp);
      }
    } else {

    }
    isLoading = false;
    update();
  }
}
