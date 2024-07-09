import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_images.dart';

class Reviews extends StatelessWidget {
  final String ratting;
  final String userName;

  final String date;

  const Reviews(
      {super.key,
      required this.ratting,
      required this.userName,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 7.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userName,
                  style: GoogleFonts.raleway(
                    color: const Color(0xFF818181),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                SvgPicture.asset(AppImages.star,
                    colorFilter: const ColorFilter.mode(
                        AppColors.yellowPrimary, BlendMode.srcIn),
                    semanticsLabel: 'A red up arrow'),
                Text(
                  "($ratting)",
                  style: GoogleFonts.raleway(),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  date,
                  style: GoogleFonts.raleway(
                    color: const Color(0xFF818181),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
