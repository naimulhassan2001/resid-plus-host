import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_icons.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final double height;
  final double width;
  final String txt;
  final String iconTxt;

  const CustomSearchBar({
    super.key,
    this.height = 40,
    this.width = 200,
    this.txt = "Search residence",
    this.iconTxt = AppIcons.searchIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 12, horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: AppColors.black10),
      ),
      height: height.h,
      width: width.w,
      child: Row(
        children: [
          SvgPicture.asset(iconTxt),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              maxLines:1,
              "searchResidence".tr,
              style: GoogleFonts.raleway(
                color: AppColors.black60,
                fontSize: 14,
                fontWeight: FontWeight.w400
              ),
            ),
          )
        ],
      ),
    );
  }
}
