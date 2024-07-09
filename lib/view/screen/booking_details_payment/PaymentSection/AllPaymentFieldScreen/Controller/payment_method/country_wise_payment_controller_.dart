import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../../../core/global/api_response_model.dart';
import '../../../../../../../utils/app_utils.dart';
import 'country_repo.dart';

import 'package:http/http.dart' as http;

import 'model/country_wise_method_model.dart';

class CountryWisePaymentController extends GetxController  {

  CountryRepo countryRepo;
  CountryWisePaymentController({required this.countryRepo});

  CountryWiseMethodModel countryWiseMethodModel = CountryWiseMethodModel();
  bool isLoading = false;

  Future<void>getCountryWisepayment ()async{

    isLoading = true;
    update();
    ApiResponseModel responseModel = await countryRepo.getCountry();
    if(responseModel.statusCode ==200){
       countryWiseMethodModel =  CountryWiseMethodModel.fromJson(jsonDecode(responseModel.responseJson));
      debugPrint("============> Response : $countryWiseMethodModel");
       isLoading = false;
       update();
    }
   else{
      Utils.toastMessage("error");
      isLoading = false;
      update();
    }
  }
}
