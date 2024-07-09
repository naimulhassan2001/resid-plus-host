import 'package:get/get.dart';
import 'package:resid_plus/view/screen/about/about_screen.dart';
import 'package:resid_plus/view/screen/add_residence/add_update_residence_screen.dart';
import 'package:resid_plus/view/screen/auth/forgot_password/forgot_password_screen.dart';
import 'package:resid_plus/view/screen/auth/new_password/new_password_screen.dart';
import 'package:resid_plus/view/screen/auth/otp/otp_screen.dart';
import 'package:resid_plus/view/screen/auth/sign_in/sign_in_screen.dart';
// import 'package:resid_plus/view/screen/auth/sign_up/inner_screen/sign_up_inner_screen.dart';
import 'package:resid_plus/view/screen/auth/sign_up/sign_up_screen.dart';
import 'package:resid_plus/view/screen/booking_details/booking_details_screen.dart';
import 'package:resid_plus/view/screen/booking_list/booking_list.dart';
import 'package:resid_plus/view/screen/booking_request_details/booking_request_details_screen.dart';
import 'package:resid_plus/view/screen/edit_profile/edit_profile_screen.dart';
import 'package:resid_plus/view/screen/history/history_screen.dart';
import 'package:resid_plus/view/screen/home/home_screen.dart';
import 'package:resid_plus/view/screen/home/innter_widgets/extra_now/popular_see_all.dart';
import 'package:resid_plus/view/screen/message/message_screen.dart';
import 'package:resid_plus/view/screen/my_residence/my_residence_screen.dart';
import 'package:resid_plus/view/screen/onboard/onboard_screen.dart';
import 'package:resid_plus/view/screen/profile/profile.dart';
import 'package:resid_plus/view/screen/settings/change_password/change_password_screen.dart';
import 'package:resid_plus/view/screen/settings/faq/faq_screen.dart';
import 'package:resid_plus/view/screen/settings/privacy/privacy_policy_screen.dart';
import 'package:resid_plus/view/screen/residence_details/residence_details.dart';
import 'package:resid_plus/view/screen/settings/settings_screen.dart';
import 'package:resid_plus/view/screen/splash/splash_screen.dart';
import 'package:resid_plus/view/screen/support/support_screen.dart';
import 'package:resid_plus/view/widgets/no_internet/no_internet.dart';

import '../../view/screen/Subscription/subscription_screen.dart';

class AppRoute {
  static const String splashScreen = "/splash_screen";
  static const String onboardScreen = "/onboard_screen";
  static const String signInScreen = "/sign_in_screen";
  static const String signUpScreen = "/sign_up_screen";
  static const String signUpInnerScreen = "/sign_up_inner_screen";
  static const String forgotPassword = "/forgot_password_screen";
  static const String newPasswordScreen = "/new_password_screen";
  static const String changePasswordScreen = "/change_password_screen";
  static const String otpScreen = "/otp_screen";
  static const String settingsScreen = "/settings_screen";
  static const String supportScreen = "/support_screen";
  static const String aboutScreen = "/about_screen";
  static const String termsOfServices = "/terms_of_services";
  static const String updateTermsOfServiceScreen = "/update_terms_of_service_screen";
  static const String privacyPolicyScreen = "/privacy_policy_screen";
  static const String updatePrivacyPolicyScreen = "/update_privacy_policy_screen";
  static const String messageScreen = "/message_screen";
  static const String bookingList = "/booking_list";
  static const String bookingDetails = "/bookingDetails";
  static const String historyScreen = "/history_screen";
  static const String navbar = "/navbar_screen";
  static const String profileScreen = "/profile_screen";
  static const String profileEditScreen = "/profile_edit_screen";
  static const String paymentMethodScreen = "/payment_method_screen";
  static const String addResidence = "/add_residence";
  static const String rattingScreen = "/ratting_screen";
  static const String hotelHome = "/popular_see_all";
  static const String myResidenceScreen = "/my_residence_screen";
  static const String residenceDetails = "/residenceDetails";
  static const String faqScreen = "/faq_screen";
  static const String homeScreen = "/home_screen";
  static const String bookingRequestDetailsScreen = "/bookingRequest_etailsScreen";
  static const String noInternet = "/no_Internet";
  static const String subscriptionScreen = "/subscription_screen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: onboardScreen, page: () => const OnboardScreen()),
    //GetPage(name: signInScreen, page: () => const SignInScreen()),
    GetPage(name: signUpScreen, page: () => const SignUpScreen()),

    GetPage(name: forgotPassword, page: () => const ForgotPassword()),
    GetPage(name: newPasswordScreen, page: () => const NewPasswordScreen()),
    GetPage(name: changePasswordScreen, page: () => const ChangePasswordScreen()),
    GetPage(name: otpScreen, page: () => const OtpScreen(isHome: true)),
    GetPage(name: settingsScreen, page: () => const SettingsScreen()),
    GetPage(name: supportScreen, page: () => const SupportScreen()),
    GetPage(name: aboutScreen, page: () => const AboutUsScreen()),
    GetPage(name: privacyPolicyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(name: messageScreen, page: () => const MessageScreen()),
    GetPage(name: bookingList, page: () => const BookingList()),
    GetPage(name: historyScreen, page: () => const HistoryScreen()),
    GetPage(name: signInScreen, page: () => const SignInScreen()),
    GetPage(name: signUpScreen, page: () => const SignUpScreen()),
    GetPage(name: addResidence, page: () => AddUpdateResidence(id: "", isUpdate: false, title: addResidence.tr)),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),

    // GetPage(name: historyScreen, page: () =>  HistoryScreen()),
    GetPage(name: profileEditScreen, page: () => const ProfileEditScreen()),
    // GetPage(name: hotelHome, page: () => const PopularSeeAll()),
    GetPage(name: myResidenceScreen, page: () => const MyResidenceScreen()),
    GetPage(name: faqScreen, page: () => const FaqScreen()),
    GetPage(name: residenceDetails, page: () => const ResidenceDetails()),
    GetPage(name: bookingRequestDetailsScreen, page: () => const BookingRequestDetailsScreen()),
    GetPage(name: bookingDetails, page: () => const BookingDetailsScreen()),
    GetPage(name: noInternet, page: () => const NoInternetScreen()),
    GetPage(name: subscriptionScreen, page: () => const SubscriptionScreen()),
  ];
}
