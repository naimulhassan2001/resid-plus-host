class ApiUrlContainer {
  static const String baseUrl = "https://resid-plus.com/api/";
  static const String socketUrl = "https://resid-plus.com";
  //
  //  static const String baseUrl = "http://103.145.138.74:5000/api/";
  //  static const String socketUrl="http://103.145.138.74:5001";

   // static const String baseUrl = "http://192.168.10.176:3010/api/";
   // static const String socketUrl= "http://192.168.10.176:3020";


  //Auth

  static const String deleteAccount = "users";
  static const String signInEndPoint = "users/signin";
  static const String signUpEndPoint = "users/signup";
  static const String forgotPassEndPoint = "users/forget/password";
  static const String oneTimeCodeEndPoint = "user/verify-code";
  static const String resetPassEndPoint = "users/reset/password";
  static const String emailVerify = "user/verify";

  // Add residence
  static const String addResidenceEndPoint = "residences";

  // home page residence
  // static const String allHotelEndPoint = "residences";
  static const String allResidenceEndPoint = "residences";
  // static const String allPersonalHouseEndPoint = "residences";

  //settings
  static const String privacyPolicyEndPoint = "privacy-policys";
  static const String termService = "terms-and-conditions";
  static const String supportEndpoint = "supports";
  static const String faqsEndpoint = "faqs";

  //about
  static const String aboutUSEndPoint = "about/all";

  // booking request
  static const String bookingReq = "bookings/";

  //Profile
  static const String profile = "user/user-info";
  static const String signUp = "users/signup";
  static const String signIn = "users/signin";
  static const String verifyOTP = "users/verify";
  static const String forgetPassVerify = "users/verify";
  static const String resendOTP = "users/resend-onetime-code?requestType=verifyEmail";


  static const String forgetPass = "users/forget/password";

  static const String resetPass = "users/reset/password";

  //My Residence
  static const String myResidences = "residences/?acceptanceStatus=all&limit=20";

  //Search Residence
  static const String searchResidence = "residences?limit=20";
  static const String searchResidence1 = "residences";

  //Settings
  static const String aboutUS = "about-us";

  // Profile
  static const String userDetails = "users/";
  static const String updateUser = "users";

  //Booking
  static const String bookingList = "bookings?bookingTypes=confirmed";
  static const String bookingHistory = "bookings?bookingTypes=history";
  static const String historyDelete = "bookings/history/";

  //notifications
  static const String notificationEndPoint = "notifications";

  //Review
  static const String reviews = "reviews/";

  //Income

  static const String income = "payments";
  static const String dailyIncome = "payments?requestType=daily";
  static const String weeklyIncome = "payments?requestType=weekly";
  static const String monthlyIncome = "payments?requestType=monthly";
  static const String amenitiesEndPoint = "amenities";
  static const String categoryEndPoint = "categories";
  static const String walletEndPoint = "incomes";
  static const String withdrawEndPoint = "payments/withdraw-payment";
  static const String countryEndpoint = "countries";
  static const String bannerNoticationEndpoint = "events";


  static const String hostSubs = "host-subs";

   static const String paymentConfirmEndPoint = "payments/make-payment?paymentTypes=";
   static const String countryPaymentEndpoint = "payment-gateways";
   static const String paymentTokenEndPoint = "payments/get-payment-token";
   static const String deleteResidenceEndPoint = "bookings/";
   static const String getPaymentToken = "payments/get-payment-token-for-subscription";
   static const String promotion = "promote-residences";




}
