import 'package:flutter/material.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_static_strings.dart';
import 'package:resid_plus/view/widgets/text/custom_text.dart';

class Back extends StatelessWidget {
  const Back(
      {super.key,
      this.horizontal = 0,
      this.vertical = 0,
      this.text = AppStaticStrings.back,
      this.fontSize = 18,
      this.height = 64,
      this.onTap});

  final double horizontal;
  final double vertical;
  final String text;
  final double fontSize;
  final double height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: Row(
          children: [
            const Icon(Icons.arrow_back_ios_new,
                size: 18, color: AppColors.blackPrimary),
            CustomText(
              left: 8,
              text: text,
              fontSize: fontSize,
            ),
          ],
        ),
      ),
    );
  }
}
