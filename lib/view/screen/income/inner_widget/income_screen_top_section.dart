import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/view/screen/income/income_controller/income_controller.dart';

class IncomeScreenTopSection extends StatefulWidget {
  const IncomeScreenTopSection({super.key});

  @override
  State<IncomeScreenTopSection> createState() => _IncomeScreenTopSectionState();
}

class _IncomeScreenTopSectionState extends State<IncomeScreenTopSection> {

  @override
  Widget build(BuildContext context) {

    return GetBuilder<IncomeController>(builder: (controller){

      return  Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 24, left: 24, bottom: 24),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(-0.00, -1.00),
            end: Alignment(0, 1),
            colors: [Color(0xFF787878), Color(0xFF434343), Colors.black],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                    text: controller.income ?? "00",
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: ' FCFA ',
                    style: GoogleFonts.raleway(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Total Income'.tr,
              style: GoogleFonts.raleway(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    });
  }
}
