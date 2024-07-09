import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/global_model/residence_model/residence_model.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/my_residence/my_residence_repo/my_residence_repo.dart';

class MyResidenceController extends GetxController {
  TextEditingController searchEditingController = TextEditingController();
  MyResidenceRepo myResidenceRepo;
  MyResidenceController({required this.myResidenceRepo});

  bool isLoading = false;


  int residencePage = 1;
  var isLoadMoreHotel = false;
  var  residenceTotalPage = (-1);
  var residenceCurrentPage = (-1);
   ScrollController residenceController = ScrollController();

  loadMoreData() async {
    print("load more");
    print("total Page $residenceTotalPage");
    print("current Page $residenceCurrentPage");
    print(isLoading);
    print(isLoadMoreHotel);
    if ( isLoading != true && isLoadMoreHotel == false && residenceTotalPage != residenceCurrentPage) {
      isLoadMoreHotel=true;
      update();
      residencePage += 1;
      if (kDebugMode) {
        print("current Page $residenceTotalPage");
      }
      ApiResponseModel response = await myResidenceRepo.myResidences(search: '',pageNo: residencePage.toString());
      if (response.statusCode == 200) {
        final ResidenceModel demoModel=  ResidenceModel.fromJson(jsonDecode(response.responseJson));
        residenceTotalPage=demoModel.data!.attributes!.pagination!.totalPage!;
        residenceCurrentPage=demoModel.data!.attributes!.pagination!.currentPage!;
        List<Residences>? tempList = demoModel.data?.attributes?.residences;
        if (tempList != null && tempList.isNotEmpty) {
          myResidenceList.addAll(tempList);
          update();
        }
      } else {
        print("error  Page ${response.responseJson}");
        residencePage =residencePage - 1;
        // ApiChecker.checkApi(response);
      }
      isLoadMoreHotel=false;
    }
  }

  // void addScrollListener() {
  //   if (residenceController.position.pixels == residenceController.position.maxScrollExtent) {
  //     loadMoreData();
  //     debugPrint("Residence Scroll Position change --------- ${residenceController.position.pixels}");
  //   }
  // }

  List<Residences> myResidenceList = [];

  ResidenceModel myResidenceModel = ResidenceModel();

  Future<void> myResidence({required String search}) async {
    myResidenceList.clear();
    isLoading = true;
    update();

    ApiResponseModel responseModel = await myResidenceRepo.myResidences(search: search, pageNo: residencePage.toString());

    if (responseModel.statusCode == 200) {
      residencePage= 1;
      myResidenceModel = ResidenceModel.fromJson(jsonDecode(responseModel.responseJson));
      myResidenceList.clear();
      List <Residences>? tempList = myResidenceModel.data?.attributes?.residences;
      if(tempList!=null&& tempList.isNotEmpty){
        myResidenceList.addAll(tempList);
      }
    } else {
      Utils.toastMessage("Something went wrong");
    }

    isLoading = false;
    update();
  }
  // @override
  // void onInit() {
  //
  //   try{
  //     residenceController.addListener(addScrollListener);
  //   }catch(e,stackTrace){
  //     print('Error in onInit: $e\n$stackTrace');
  //   }
  //
  //   // TODO: implement onInit
  //   super.onInit();
  // }
}
