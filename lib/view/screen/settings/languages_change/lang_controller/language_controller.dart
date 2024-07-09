import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController{

  final data = GetStorage();

  Future<void> initStorage() async{
    await GetStorage.init();
    update();
  }

  final language = false.val("lang");

  void toggleLanguage() {
    language.val = !language.val;
    update();
  }
}