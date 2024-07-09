import 'package:flutter/material.dart';
import 'package:resid_plus/utils/app_icons.dart';
import 'package:resid_plus/utils/app_static_strings.dart';
import 'package:resid_plus/view/widgets/image/custom_image.dart';
import 'package:resid_plus/view/widgets/text/custom_text.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImage(imageSrc: AppIcons.noInternet),
            CustomText(
              top: 44,
              text: AppStaticStrings.noInterNet,
              bottom: 60,
            ),
          ],
        ),
      ),
    );
  }
}
