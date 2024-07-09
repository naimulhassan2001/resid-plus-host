import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/utils/app_colors.dart';

class IncomeCard extends StatelessWidget {

  final VoidCallback? press;
  final String title;

  const IncomeCard({

    this.press,
    required this.title,
    super.key
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: press,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsetsDirectional.symmetric(vertical: 18, horizontal: 16),
        decoration: ShapeDecoration(
          color: AppColors.transparentColor,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.5, color: AppColors.black60),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: GoogleFonts.raleway(
                color: AppColors.blackPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SvgPicture.asset("assets/icons/arrow_right.svg")
          ],
        ),
      ),
    );
  }
}
