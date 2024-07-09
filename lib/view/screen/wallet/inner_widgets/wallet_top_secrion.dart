import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/view/screen/wallet/wallet_controller/wallet_controller.dart';
import 'package:resid_plus/view/screen/wallet/wallet_controller/wallet_repo.dart';

class WalletTopSection extends StatefulWidget {
  const WalletTopSection({super.key});

  @override
  State<WalletTopSection> createState() => _WalletTopSectionState();
}

class _WalletTopSectionState extends State<WalletTopSection> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(WalletRepo(apiService: Get.find()));
    Get.put(WalletController(walletRepo: Get.find()));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
      builder: (controller) {
        return Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 24, left: 24, bottom: 24),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF787878), Color(0xFF434343), Colors.black],
                ),
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [

                        TextSpan(
                          text: "Available Balance".tr,
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16,),
                  SvgPicture.asset(
                      "assets/icons/money_icon.svg",
                     width: 40,
                    height: 30,
                  ),
                  const SizedBox(height: 12),
                  controller.isLoading? const Center(child: SizedBox(height:20,width:20,child: CircularProgressIndicator()),) : Text(
                    "${controller.income.pendingAmount}${" FCFA"}",
                    // controller.income.pendingAmount == 0 ? "00": "${controller.income.pendingAmount}${" FCFA"}",
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ],
              ),
            )
          ],
        );
      }
    );
  }
}
