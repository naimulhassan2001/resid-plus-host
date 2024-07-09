import 'package:get/get.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/service/socket_service.dart';
import 'package:resid_plus/view/screen/add_residence/add_residence_controller/add_residence_controller.dart';
import 'package:resid_plus/view/screen/auth/sign_in/sign_in_repo/sign_in_repo.dart';
import 'package:resid_plus/view/screen/edit_profile/edit_profile_controller/edit_profile_controller.dart';
import 'package:resid_plus/view/screen/wallet/wallet_controller/wallet_controller.dart';
import 'package:resid_plus/view/screen/wallet/wallet_controller/wallet_repo.dart';
import 'package:resid_plus/view/widgets/no_internet/no_internet_controller/no_internet_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../view/screen/Subscription/subscription_controller.dart';
import '../../view/screen/residence_promotion/residence_promotion_controller.dart';

Future<void> initDependency() async {
  final sharedPreference = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreference, fenix: true);
  Get.lazyPut(() => SignInRepo(apiService: Get.find()), fenix: true);
  Get.lazyPut(() => ApiService(sharedPreferences: Get.find()), fenix: true);
  Get.lazyPut(() => EditProfileController(), fenix: true);
  Get.lazyPut(() => SocketService(), fenix: true);
  Get.lazyPut(() => AddUpdateResidenceController(apiService: Get.find()),
      fenix: true);
  Get.lazyPut(() => WalletController(walletRepo: Get.find()), fenix: true);
  Get.lazyPut(() => WalletRepo(apiService: Get.find()), fenix: true);
  Get.lazyPut(() => SubscriptionController(), fenix: true);
  Get.lazyPut(() => ResidencePromotionController(), fenix: true);

  Get.put<NoInternetController>(NoInternetController(), permanent: true);

  Get.find<SocketService>().connectToSocket();
}
