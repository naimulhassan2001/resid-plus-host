import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/core/helper/shear_preference_helper.dart';
import 'package:resid_plus/utils/app_utils.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MonthlyIncomeController extends GetxController {
  Map<String, dynamic> parsedJson = {};

  List<Map<String, dynamic>> monthAndAmmountValueList = [];

  bool isLoading = true;

  Future<void> getMonthlyIncome() async {
    try {
      isLoading = true;
      update();
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(SharedPreferenceHelper.accessTokenKey);
      String url = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.monthlyIncome}";

      Uri urlparse = Uri.parse(url);
      var response = await http.get(urlparse, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      });

      if (response.statusCode == 200) {
        parsedJson = jsonDecode(response.body);
        Map<String, dynamic> data = parsedJson['data'];

        for (String key in data.keys) {
          int value = data[key];
          monthAndAmmountValueList.add({
            "date": key,
            "amount": value,
          });
        }

        print(monthAndAmmountValueList);
      } else {
        Utils.toastMessage("Something went wrong");
      }
      isLoading = false;
      update();
    } on Exception catch (e) {
      Utils.toastMessage("Something went wrong $e");
    }
  }

  @override
  void onInit() {
    getMonthlyIncome();
    super.onInit();
  }
}
