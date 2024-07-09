import 'dart:convert';

import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/notification/notification_repo/notification_repo.dart';
import 'package:resid_plus/view/screen/notification/notifocation_model/notification_model.dart';

class NotificationController extends GetxController {
  NotificationRepo notificationRepo;
  NotificationController({required this.notificationRepo});

  NotificationModel notificationModel = NotificationModel();
  bool isLoading = true;
  List<AllNotification> dataList = [];
  getNotification() async {
    ApiResponseModel responseModel = await notificationRepo.notificationsResponse();

    if (responseModel.statusCode == 200) {
      notificationModel = NotificationModel.fromJson(jsonDecode(responseModel.responseJson));
      isLoading = true;
      update();

      List<AllNotification>? tempList = notificationModel.data?.attributes?.allNotification;

      if (tempList != null && tempList.isNotEmpty) {
        dataList.addAll(tempList);
      }
    } else {
      Utils.toastMessage("Something went wrong");
    }
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    getNotification();
    super.onInit();
  }
}
