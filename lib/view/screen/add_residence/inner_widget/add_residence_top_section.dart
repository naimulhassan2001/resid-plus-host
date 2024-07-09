import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_icons.dart';
import 'package:resid_plus/view/screen/add_residence/add_residence_controller/add_residence_controller.dart';

class AddResidenceTopSection extends StatefulWidget {
  const AddResidenceTopSection({super.key});

  @override
  State<AddResidenceTopSection> createState() => _AddResidenceTopSectionState();
}

class _AddResidenceTopSectionState extends State<AddResidenceTopSection> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddUpdateResidenceController>(builder: (controller) {
      return controller.selectedImages.isNotEmpty &&
              controller.selectedImagesOnline.isEmpty
          ? Column(
              children: [
                CarouselSlider.builder(
                  itemCount: controller.selectedImages.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageIndex) =>
                          Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    height: 350,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(
                                controller.selectedImages[itemIndex].path)),

                        ),
                        color: const Color(0xFFECECEC),
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: controller.selectedImages.isEmpty
                        ? SvgPicture.asset(
                            AppIcons.galleryIcon,
                            height: 24,
                            width: 24,
                          )
                        : const SizedBox(),
                  ),
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    height: 350,
                    autoPlay: true,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DotsIndicator(
                  decorator: const DotsDecorator(
                    activeColor: AppColors.blackPrimary,
                  ),
                  dotsCount: controller.selectedImages.length,
                  position: currentIndex,
                )
              ],
            )
          : controller.selectedImages.isEmpty &&
                  controller.selectedImagesOnline.isNotEmpty
              ? Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: controller.selectedImagesOnline.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageIndex) =>
                          Container(
                        margin: const EdgeInsets.only(right: 10, left: 10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(controller
                                    .selectedImagesOnline[itemIndex])),
                            color: const Color(0xFFECECEC),
                            borderRadius: BorderRadius.circular(8)),
                        alignment: Alignment.center,
                      ),
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        enableInfiniteScroll: false,
                        viewportFraction: 1,
                        height: 350.0,
                        autoPlay: true,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DotsIndicator(
                      decorator: DotsDecorator(
                        color: Colors.grey.withOpacity(0.2),
                        activeColor: AppColors.blackPrimary,
                      ),
                      dotsCount: controller.selectedImagesOnline.length,
                      position: currentIndex,
                    )
                  ],
                )
              : SizedBox(
                  height: 350,
                  child: DottedBorder(
                    color: const Color(0xFF818181),
                    borderType: BorderType.RRect,
                    dashPattern: const [10, 6],
                    radius: const Radius.circular(8),
                    child: Container(
                      height: 350,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: const Color(0xFFECECEC),
                          borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        AppIcons.galleryIcon,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                );
    });
  }
}
