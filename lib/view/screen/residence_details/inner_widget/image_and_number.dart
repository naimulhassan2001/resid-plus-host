import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resid_plus/utils/app_colors.dart';

class ImageWithNumber extends StatelessWidget {
  const ImageWithNumber(
      {super.key, required this.imageName, required this.number});
  final String imageName;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Row(
        children: [
          SizedBox(
            width: 14.w,
            height: 14.h,
            child: SvgPicture.asset(imageName,
                colorFilter:
                    const ColorFilter.mode(AppColors.black60, BlendMode.srcIn),
                semanticsLabel: 'A red up arrow'),
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            number,
            style: TextStyle(fontSize: 12.sp),
          )
        ],
      ),
    );
  }
}
