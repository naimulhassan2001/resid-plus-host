import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_static_strings.dart';
import 'package:resid_plus/view/widgets/text/custom_text.dart';

class CustomField extends StatelessWidget {
  const CustomField({super.key,
      this.textInputType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.text = "",
      this.isLabel = true,
      this.hintText = AppStaticStrings.enterNumber,
      this.fontSize = 14,
      this.bottom = 8,
      this.top = 16,
      this.borderRadius = 8,
      this.borderWidth = 0.50,
      this.borderSideColor = AppColors.black10,
      this.fontWeight = FontWeight.w400,
      this.hintTextColor = AppColors.black60,
      this.width = double.maxFinite,
      this.backgroundColor = Colors.white,
      this.paddingLeft = 16,
      this.paddingRight = 16,
      this.paddingTop = 16,
      this.paddingBottom = 16,
      this.alignment = Alignment.center,
      this.contentPaddingLeft = 12,
      this.contentPaddingRight = 0,
      this.contentPaddingTop = 10,
      this.contentPaddingBottom = 10,
      this.controller,
      this.readOnly = false,
      this.maxLines = 1,
      this.validator,
      this.keys
  });
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final double width;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final double fontSize;
  final double bottom;
  final double top;
  final double borderRadius;
  final double borderWidth;
  final Color borderSideColor;
  final Color backgroundColor;
  final FontWeight fontWeight;
  final Color hintTextColor;
  final String text;
  final String hintText;
  final Alignment alignment;
  final double contentPaddingLeft;
  final double contentPaddingRight;
  final double contentPaddingTop;
  final double contentPaddingBottom;
  final bool isLabel;
  final bool readOnly;
  final int maxLines;
  final Key ? keys;



  final TextEditingController? controller;
  final FormFieldValidator ? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isLabel
            ? CustomText(
                text: text,
                bottom: bottom,
                top: top,
              )
            : const SizedBox(),
        const SizedBox(height: 8),
        TextFormField(
          key: keys,
          maxLines: maxLines,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          readOnly: readOnly,
             controller: controller,
            validator: validator,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
                top: contentPaddingTop,
                bottom: contentPaddingBottom,
                left: contentPaddingLeft,
                right: contentPaddingRight
            ),
            hintText: hintText,
            hintStyle: GoogleFonts.raleway(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: hintTextColor),
            fillColor: AppColors.transparentColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: Color(0xffe2e2e2), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: AppColors.blackPrimary, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: Color(0xffe2e2e2), width: 1),
            ),
          ),
        )
      ],
    );
  }
}
