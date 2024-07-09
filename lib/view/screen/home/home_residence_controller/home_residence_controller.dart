import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/global_model/residence_model/residence_model.dart';
import 'package:resid_plus/view/screen/home/home_residence_repo/home_residence_repo.dart';

class HomeController extends GetxController {
  HomeRepo homeRepo;

  HomeController({required this.homeRepo});

  bool isLoading = false;
   bool residenceLoading = false;
  int residencePage = 1;
  var isLoadMoreHotel = false;
  var  residenceTotalPage = (-1);
  var residenceCurrentPage = (-1);
  ScrollController scrollController = ScrollController();
  loadMoreData() async {
    print("load more");
    print("total Page $residenceTotalPage");
    print("current Page $residenceCurrentPage");
    print(isLoadMoreHotel);
    if ( residenceLoading != true && isLoadMoreHotel == false && residencePage != residenceCurrentPage) {
      isLoadMoreHotel=true;
      update();
      residencePage += 1;
      if (kDebugMode) {
        print("current Page $residenceCurrentPage");
      }

      ApiResponseModel response = await homeRepo.allResidenceResponse(residencePage.toString());
      if (response.statusCode == 200) {
        final ResidenceModel demoModel=  ResidenceModel.fromJson(jsonDecode(response.responseJson));
        residenceTotalPage=demoModel.data!.attributes!.pagination!.totalPage!;
        residenceCurrentPage=demoModel.data!.attributes!.pagination!.currentPage!;
        List<Residences>? tempList = demoModel.data?.attributes?.residences;
        if (tempList != null && tempList.isNotEmpty) {
          allResidencesDataList.addAll(tempList);
          update();
        }
      } else {
        print("error  Page ${response.responseJson}");
        residenceTotalPage = residenceTotalPage - 1;
      }
      isLoadMoreHotel=false;
    }
  }
  void addScrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      // loadMoreData();
    }
  }

  ResidenceModel homeModel = ResidenceModel();
  List<Residences> allResidencesDataList = [];


  void initialState() async {
    allResidencesDataList.clear();
   await allResidencesData();
    loadMoreData();
   isLoading = false;
   update();
  }

  Future<void> allResidencesData() async {
    residencePage = 1;
    isLoading = true;
    update();
    ApiResponseModel responseModel = await homeRepo.allResidenceResponse(residencePage.toString());
    if (responseModel.statusCode == 200) {
      homeModel = ResidenceModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Residences>? tempList = homeModel.data?.attributes?.residences;
      if (tempList != null && tempList.isNotEmpty) {
        allResidencesDataList.addAll(tempList);
      }
    }
    update();
  }



  @override
  void onInit() {
    try {
      scrollController.addListener(addScrollListener);
    } catch (e, stackTrace) {
      print('Error in onInit: $e\n$stackTrace');
    }
    super.onInit();
  }
}