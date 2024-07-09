import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/view/screen/home/home_residence_controller/home_residence_controller.dart';
import '../../../../core/route/app_route.dart';
import '../../../../utils/app_colors.dart';

class HomeScreenData extends StatefulWidget {
  const HomeScreenData({super.key});

  @override
  State<HomeScreenData> createState() => _HomeScreenDataState();
}

class _HomeScreenDataState extends State<HomeScreenData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) => controller.isLoading
            ? const Center(
          child: CircularProgressIndicator(color: AppColors.blackPrimary),
        )
            : controller.allResidencesDataList.isNotEmpty
                 ? ListView.builder(
               controller: controller.scrollController,
               scrollDirection: Axis.vertical,
              padding: const EdgeInsetsDirectional.only(
                  start: 20, bottom: 24, end: 20),
              itemCount:  controller.isLoading
                  ? controller.allResidencesDataList.length + 1
                  : controller.allResidencesDataList.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index)
              {
                if(index<controller.allResidencesDataList.length)
                {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: GestureDetector(
                      onTap: () => Get.toNamed(
                        AppRoute.residenceDetails,
                        arguments: [
                          controller.allResidencesDataList,
                          index,
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            padding: const EdgeInsetsDirectional.only(
                                top: 8, end: 8),
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  controller.allResidencesDataList[index]
                                      .photo![0].publicFileUrl
                                      .toString(),
                                ),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.allResidencesDataList[index]
                                          .residenceName ??
                                          "",
                                      style: GoogleFonts.raleway(
                                        color: const Color(0xFF333333),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Color(0xFFFBA91D),
                                          size: 18,
                                        ),
                                        const SizedBox(width: 4),
                                        Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '(',
                                                style:
                                                GoogleFonts.raleway(
                                                  color: const Color(
                                                      0xFF333333),
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                              TextSpan(
                                                text: controller
                                                    .allResidencesDataList[
                                                index]
                                                    .ratings
                                                    .toString(),
                                                style:
                                                GoogleFonts.openSans(
                                                  color: const Color(
                                                      0xFF333333),
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.w400,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ')',
                                                style:
                                                GoogleFonts.raleway(
                                                  color: const Color(
                                                      0xFF333333),
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/location.svg",
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      controller.allResidencesDataList[index]
                                          .city
                                          .toString(),
                                      style: GoogleFonts.raleway(
                                        color: const Color(0xFF818181),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                else{
                  return const Center(
                      child: CircularProgressIndicator(color: AppColors.blackPrimary,));
                }
              },
            )
                : const SizedBox(),
      ),
    );




  }
}
