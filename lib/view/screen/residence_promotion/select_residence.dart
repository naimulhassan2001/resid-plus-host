import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/view/screen/residence_promotion/my_residence_model.dart';
import 'package:resid_plus/view/screen/residence_promotion/residence_promotion_controller.dart';
import 'package:resid_plus/view/widgets/image/custom_image.dart';

import '../../../utils/app_colors.dart';
import '../../widgets/buttons/custom_elevated_button.dart';
import '../../widgets/text/custom_text.dart';

void selectResidence(subscriptionItem) {
  showDialog(
    context: Get.context!,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          margin: EdgeInsets.symmetric(vertical: 40.h),
          width: double.maxFinite,
          child: StatefulBuilder(builder: (context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  fontSize: 18.w,
                  fontWeight: FontWeight.w500,
                  text: 'select a Residence'.tr,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    ResidencePromotionController.instance.myResidence.length,
                    (index) {
                      MyResidence item = ResidencePromotionController
                          .instance.myResidence[index];
                      return InkWell(
                        onTap: () {
                          ResidencePromotionController.instance.getPaymentToken(
                              id: item.id,
                              amount: subscriptionItem['price'].toString());
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: AppColors.whiteColor)),
                          child: Row(
                            children: [
                              Image.network(
                                item.photos.isNotEmpty
                                    ? item.photos[0].publicFileUrl
                                    : '',
                                height: 80,
                                width: 80,
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: item.residenceName,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                    ),
                                    CustomText(
                                      text: item.status,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      maxLines: 2,
                                      color: AppColors.primaryColor,
                                      textAlign: TextAlign.start,
                                      bottom: 10.h,
                                      top: 4.h,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                //========================Confirm Button==========================
              ],
            );
          }),
        ),
      );
    },
  );
}
