import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:resid_plus/core/di_service/dependency_injection.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/service/ads_service.dart';
import 'package:resid_plus/service/notification.dart';
import 'package:resid_plus/service/push_notification.dart';
import 'package:resid_plus/view/screen/Subscription/subscription_screen.dart';
import 'package:resid_plus/view/screen/settings/languages_change/lang_controller/language_controller.dart';
import 'package:resid_plus/view/screen/settings/languages_change/languages_translator.dart';

import 'firebase_options.dart';

FlutterLocalNotificationsPlugin fln = FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  await ScreenUtil.ensureScreenSize();
  await initDependency();

  await Get.put(LanguageController()).initStorage();
  await MobileAds.instance.initialize();
  // NotificationHelper nC = NotificationHelper();
  NotificationHelper.initLocalNotification(fln);
  AdsServices.loadInterstitialAd();
  AdsServices.loadBannerAd();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PushNotification notificationService = PushNotification();

  void initState() {
    notificationService.initLocalNotification();
    notificationService.requestNotificationPermission();
    notificationService.firebaseInit();
    notificationService.foreGroundMessage();
    //notificationService.myBackgroundMessageHandler();
    notificationService.sendToken();
    notificationService.getDeviceFcmToken().then((value) {
      print(value);
    });

    super.initState();
  }

  final data = GetStorage();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 200),
      initialRoute: AppRoute.splashScreen,
      navigatorKey: Get.key,
      getPages: AppRoute.routes,
      translations: Languages(),
      locale: Get.find<LanguageController>().language.val
          ? const Locale("en", "US")
          : const Locale("fr", "CA"),
      fallbackLocale: const Locale("en", "US"),
      // home: SubscriptionScreen(),
    );
  }
}
