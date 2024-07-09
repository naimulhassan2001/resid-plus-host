import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../core/global/api_response_model.dart';
import '../../../../service/api_service.dart';
import '../home_residence_repo/home_residence_repo.dart';
import 'model.dart';

class EventsController extends GetxController{
  List <Attribute> notifiactionList = [];
  bool isLoading = false;
  EventModel eventModel = EventModel();
  ApiService apiService;
  HomeRepo homeRepo;
  EventsController({required this.homeRepo, required this.apiService});
  Future<void> getNottifiaction() async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await homeRepo.responseNotification();
    if (responseModel.statusCode == 200) {
      eventModel = EventModel.fromJson(jsonDecode(responseModel.responseJson));
      List<Attribute>?tempList = eventModel.data?.attributes ;

      if (tempList != null && tempList.isNotEmpty) {
       // notifiactionList.clear();
        notifiactionList.addAll(tempList);
        update();
      }
    } else {
      debugPrint("Error");
    }
    isLoading = false;
    update();
  }

  bool  isShow = true;
  check(){
    isShow = !isShow;
    update();
    print(isShow);
  }
@override
  void onInit() {

    getNottifiaction();
    // TODO: implement onInit
    super.onInit();
  }
}