import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/view/screen/wallet/inner_widgets/wallet_top_secrion.dart';
import 'package:resid_plus/view/screen/wallet/withdraw/withdraw_controller/withdraw_controller.dart';
import 'package:resid_plus/view/screen/wallet/withdraw/withdraw_repo/withdraw_repo.dart';
import 'package:resid_plus/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_button.dart';
import 'package:resid_plus/view/widgets/custom_text_field/custom_text_field.dart';

import '../../widgets/buttons/custom_elevated_loading_button.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final formKey = GlobalKey<FormState>();
  bool isSelected = false;
  int selectedIndex = 0;


  List<Map<String, String>> withdrawMethods = [
    {"image" : "assets/images/wave.png", "method" : "Wave","paymentType":"wave-ci"},
    {"image" : "assets/images/orange.png", "method" : "Orange","paymentType":"orange-money-ci"},
    {"image" : "assets/images/mtn.png", "method" : "MTN","paymentType":"mtn-ci"},
    {"image" : "assets/images/moov.png", "method" : "Moov","paymentType":"moov-ci"},

  ];

   late WithdrawController _withdrowController;

  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(WithdrawRepo(apiService: Get.find()));
   _withdrowController= Get.put(WithdrawController(withdrawRepo: Get.find()));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Scaffold(
      appBar: CustomAppBar(
        appBarContent: GestureDetector(
          onTap: () => Get.back(),
          child: Row(
            children: [
              const Icon(Icons.arrow_back_ios,
                  color: AppColors.blackPrimary, size: 18),
              const SizedBox(width: 8),
              Text(
                "Wallet".tr,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
      body:  SingleChildScrollView(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20,vertical: 24),
        child: GetBuilder<WithdrawController>(builder: (controller){
          return Column(
            children: [
              const WalletTopSection(),
              const SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Withdraw Money'.tr,
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  SvgPicture.asset("assets/icons/pepicons-pop_down-up.svg"),
                ],
              ),
              const SizedBox(height: 16,),
              CustomTextField(
                title: 'Phone Number'.tr,
                maxLength: 10,
                hintText: "Enter Your Phone Number".tr,
                textEditingController: controller.cardNumberController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                    color: AppColors.black40),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Enter Your Phone Number".tr;
                  }
                  else if(value.toString().length <8 ){
                    return "Enter Your Valid Phone Number".tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16,),
              CustomTextField(
                title: 'Amount'.tr,
                hintText: "Enter your amount".tr,
               textEditingController: controller.amountController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1,
                    color: AppColors.black40),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Enter your amount".tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Withdrawn Mode".tr,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.raleway(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackPrimary
                    ),
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                         isSelected = !isSelected;
                         // selectedIndex =0;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                          color: AppColors.transparentColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: isSelected ? AppColors.blackPrimary : AppColors.black10, width: 1)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isSelected?   Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset("${withdrawMethods[selectedIndex]["image"]}", height: 30, width: 30),
                              const SizedBox(width: 8),
                              Text(
                                "${withdrawMethods[selectedIndex]["method"]}",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: AppColors.blackPrimary,
                                ),
                              ),

                            ],
                          ): Text(
                            "Select withdrawals".tr,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.raleway(
                                color: AppColors.black80,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                          isSelected ? const Icon(
                              Icons.keyboard_arrow_up_sharp,
                              color: AppColors.blackPrimary,
                              size: 24
                          ) : const Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColors.blackPrimary,
                              size: 24
                          )
                        ],
                      ),
                    ),
                  ),
                  isSelected ?  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 16),
                    decoration: const BoxDecoration(
                      color: AppColors.transparentColor,
                      border: Border(
                        top: BorderSide.none,
                        left: BorderSide(color: AppColors.black10, width: 1),
                        right: BorderSide(color: AppColors.black10, width: 1),
                        bottom: BorderSide(color: AppColors.black10, width: 1),
                      ),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(withdrawMethods.length, (index) => Padding(
                          padding: EdgeInsets.only(bottom: index == withdrawMethods.length - 1 ? 0 : 16),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                selectedIndex = index;
                                print(_withdrowController.withdrawmode);
                                _withdrowController.withdrawmode=withdrawMethods[selectedIndex]['paymentType']!;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset("${withdrawMethods[index]["image"]}", height: 30, width: 30),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${withdrawMethods[index]["method"]}",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.raleway(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColors.black80,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                    ),
                  ) :const SizedBox()
                ],
              )
            ],
          );
        })
      ),
        bottomNavigationBar: GetBuilder<WithdrawController>(builder: (controller){
          return SingleChildScrollView(
            padding: const EdgeInsetsDirectional.only(start: 20, end: 20, bottom: 24),
            physics: const ClampingScrollPhysics(),
            child: isLoading == true ? const CustomElevatedLoadingButton() : CustomElevatedButton(
              onPressed: (){
                controller.withdrawMoney();
              },
              titleText: 'Withdraw'.tr,
            ),
          );
        })
    );
  }
}
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue previousValue,
      TextEditingValue nextValue,
      ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
