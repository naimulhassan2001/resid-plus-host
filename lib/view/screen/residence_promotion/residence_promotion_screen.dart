import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resid_plus/view/screen/residence_promotion/residence_promotion_controller.dart';
import 'package:resid_plus/view/screen/residence_promotion/select_residence.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/text/custom_text.dart';

class ResidencePromotionScreen extends StatefulWidget {
  const ResidencePromotionScreen({super.key});

  @override
  State<ResidencePromotionScreen> createState() =>
      _ResidencePromotionScreenState();
}

class _ResidencePromotionScreenState extends State<ResidencePromotionScreen> {
  final PageController pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios, size: 22.w)),
        title: const CustomText(
          text: "Subscription",
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      body: GetBuilder<ResidencePromotionController>(
        builder: (controller) {
          return controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: controller.promotions.length,
                    itemBuilder: (context, index) {
                      var item = controller.promotions[index];
                      return buildColumn(item);
                    },
                  ),
                );
        },
      ),
    );
  }

  Column buildColumn(item) {
    bool isChecked = true;

    void _handleCheckboxChanged(bool? value) {
      setState(() {
        isChecked = value ?? false;
        print(value);
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 100.h,
        ),
        Container(
          width: 280.w,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.blackPrimary),
              borderRadius: BorderRadius.circular(12.r)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                width: 280.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r)),
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.blackUp,
                          AppColors.blackDown,
                          Colors.black
                        ])),
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        height: 50.h,
                        width: 55.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.whiteColor),
                        child: SvgPicture.asset(AppIcons.crown)),
                    CustomText(
                      top: 8,
                      bottom: 4,
                      text: item['name'].toString(),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteColor,
                    ),
                    CustomText(
                      text: "${item['price']} FCFA/month",
                      color: AppColors.whiteColor,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 36.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.blackPrimary,
                      value: isChecked,
                      onChanged: _handleCheckboxChanged,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                        child: const CustomText(
                            textAlign: TextAlign.left,
                            maxLines: 5,
                            text: 'show  residence on top'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              // Checkbox(value: , onChanged: onChanged)
              CustomButton(
                  horizontalMargin: 36.w,
                  onTap: () async {
                    await ResidencePromotionController.instance
                        .getMyResidenceRepo();
                    ResidencePromotionController.instance.isLoadingResidence
                        ? selectResidence(item)
                        : selectResidence(item);
                  },
                  title: "Buy Now"),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        )
      ],
    );
  }
}
