import 'package:get/get.dart';
import 'package:resid_plus/view/screen/settings/languages_change/english.dart';
import 'package:resid_plus/view/screen/settings/languages_change/france.dart';


class Languages extends Translations{

  @override
  Map<String, Map<String, String>> get keys => {

    "en_US" : english,
    "fr_CA" : france
  };
}