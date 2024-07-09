import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/core/global/global_model/residence_model/residence_model.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/search/search_repo/search_repo.dart';
import 'package:resid_plus/view/screen/add_residence/category/category_model/category_model.dart' as cm;


class SearchResidenceController extends GetxController {



  ///   Search Screen
  SearchResidenceRepo searchResidenceRepo;
  SearchResidenceController({required this.searchResidenceRepo});
  bool isLoading = false;
  ResidenceModel searchResidenceModel = ResidenceModel();
  List<Residences> searchList = [];
  TextEditingController searchController = TextEditingController();

  Future<void> searchedResidence(String search) async {

    isLoading = true;
    update();
    searchList.clear();

    search = searchController.text;

    ApiResponseModel responseModel = await searchResidenceRepo.mySearchedResidence(search: search);
    if (responseModel.statusCode == 200) {
      searchResidenceModel = ResidenceModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residences>? tempList = searchResidenceModel.data?.attributes?.residences;
      if (tempList != null && tempList.isNotEmpty) {
        searchList.addAll(tempList);
      }
    } else if (responseModel.statusCode == 503) {
      Get.offAllNamed(AppRoute.noInternet);
    } else {
      Utils.toastMessage("Something went wrong".tr);
    }
    isLoading = false;
    update();
  }

  Future<void> filterResidence(String filter) async {
    searchList.clear();
    isLoading = true;
    update();

    ApiResponseModel responseModel = await searchResidenceRepo.filterResidence(filter: filter);
    if (responseModel.statusCode == 200) {
      searchResidenceModel = ResidenceModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residences>? tempList = searchResidenceModel.data?.attributes?.residences;
      if (tempList != null && tempList.isNotEmpty) {
        searchList.addAll(tempList);
      }
    } else if (responseModel.statusCode == 503) {
      Get.offAllNamed(AppRoute.noInternet);
    } else {
      Utils.toastMessage("Something went wrong".tr);
    }

    isLoading = false;
    update();
  }

  cm.CategoryModel categoryModel = cm.CategoryModel();
  List<cm.Attributes> categoryList = [];

  Future<void> fetchCategory() async{
    categoryList.clear();
    isLoading = true;
    update();

    String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.categoryEndPoint}";

    String  requestMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel = await searchResidenceRepo.apiService.request(url, requestMethod, null, passHeader: true);

    if(responseModel.statusCode == 200){
      categoryModel = cm.CategoryModel.fromJson(jsonDecode(responseModel.responseJson));
      List<cm.Attributes>? tempList = categoryModel.data?.attributes;

      if(tempList != null && tempList.isNotEmpty){
        categoryList.addAll(tempList);
      }
    }

    isLoading = false;
    update();
  }
}
