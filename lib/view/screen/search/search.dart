import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_icons.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/search/search_controller/search_controller.dart';
import 'package:resid_plus/view/screen/search/search_repo/search_repo.dart';
import 'package:resid_plus/view/screen/settings/languages_change/lang_controller/language_controller.dart';
import 'package:resid_plus/view/widgets/bottom_nav/custom_bottom_nav_bar.dart';
import 'package:resid_plus/view/widgets/custom_text_field/custom_search_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    DeviceUtils.bottomNavUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(SearchResidenceRepo(apiService: Get.find()));
    Get.put(LanguageController()).initStorage();
    final controller = Get.put(SearchResidenceController(searchResidenceRepo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.searchedResidence("");
      controller.fetchCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 64),
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsetsDirectional.only(
                  start: 20, end: 20, top: 24, bottom: 0),
              color: Colors.transparent,
              child: Text(
                "search".tr,
                style: GoogleFonts.raleway(
                  color: const Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
        body: GetBuilder<SearchResidenceController>(builder: (controller) {
          return LayoutBuilder(
            builder: (context, BoxConstraints constraints) => Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 20, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomSearchField(
                          controller: controller.searchController,
                          onChanged: (value) {
                            Future.delayed(
                              const Duration(seconds: 1),
                              () {
                                controller.searchedResidence(value);
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      PopupMenuButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusDirectional.circular(8)),
                        position: PopupMenuPosition.under,
                        offset: const Offset(0, 0),
                        child: Container(
                          height: 50,
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 16, vertical: 16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.transparentColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: AppColors.black10, width: 1)),
                          child: SvgPicture.asset(AppIcons.filterIcon),
                        ),
                        itemBuilder: (context) {
                          return List.generate(
                            controller.categoryList.length,
                            (index) {
                              return PopupMenuItem(
                                onTap: () {
                                  controller.filterResidence(
                                      "${controller.categoryList[index].id}");
                                },
                                child: Text(
                                  Get.find<LanguageController>().language.val
                                      ? controller.categoryList[index]
                                              .translation?.en ??
                                          "---"
                                      : controller.categoryList[index]
                                              .translation?.fr ??
                                          "---",
                                  style: GoogleFonts.raleway(
                                      color: AppColors.blackPrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
                Flexible(
                    child: controller.isLoading ?
                    const Center(child: CircularProgressIndicator(color: AppColors.blackPrimary,),) :
                     controller.searchList.isNotEmpty ? SingleChildScrollView(
                                padding: const EdgeInsetsDirectional.only(
                                    bottom: 24, start: 20, end: 20),
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: List.generate(
                                      controller.searchList.length,
                                      (index) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 24),
                                            child: GestureDetector(
                                              onTap: () => Get.toNamed(
                                                  AppRoute.residenceDetails,
                                                  arguments: [
                                                    controller.searchList,
                                                    index,
                                                  ]),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 300,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .only(
                                                            top: 8, end: 8),
                                                    decoration: ShapeDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            controller
                                                                .searchList[
                                                                    index]
                                                                .photo![0]
                                                                .publicFileUrl
                                                                .toString()),
                                                        fit: BoxFit.fill,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 16),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                controller
                                                                        .searchList[
                                                                            index]
                                                                        .residenceName ??
                                                                    "",
                                                                style:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  color: const Color(
                                                                      0xFF333333),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Color(
                                                                          0xFFFBA91D),
                                                                      size: 18),
                                                                  const SizedBox(
                                                                      width: 4),
                                                                  Text.rich(
                                                                    TextSpan(
                                                                      children: [
                                                                        TextSpan(
                                                                          text:
                                                                              '(',
                                                                          style:
                                                                              GoogleFonts.raleway(
                                                                            color:
                                                                                const Color(0xFF333333),
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text: controller
                                                                              .searchList[index]
                                                                              .ratings
                                                                              .toString(),
                                                                          style:
                                                                              GoogleFonts.openSans(
                                                                            color:
                                                                                const Color(0xFF333333),
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              ')',
                                                                          style:
                                                                              GoogleFonts.raleway(
                                                                            color:
                                                                                const Color(0xFF333333),
                                                                            fontSize:
                                                                                12,
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
                                                          const SizedBox(
                                                              height: 8),
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                  "assets/icons/location.svg"),
                                                              const SizedBox(
                                                                  width: 4),
                                                              Text(
                                                                controller
                                                                    .searchList[
                                                                        index]
                                                                    .city
                                                                    .toString(),
                                                                style:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  color: const Color(
                                                                      0xFF818181),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ),
                                          )),
                                ),
                              ) : Center(child: Text("No Data Found".tr, style: GoogleFonts.raleway(fontSize: 20)))
                )
              ],
            ),
          );
        }),
        bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
      ),
    );
  }
}
