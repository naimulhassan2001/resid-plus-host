import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/core/global/global_model/residence_model/residence_model.dart';
import 'package:resid_plus/core/helper/date_converter_helper.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/residence_details/inner_widget/image_and_number.dart';
import 'package:resid_plus/view/screen/residence_details/inner_widget/review/review_controller/review_controller.dart';
import 'package:resid_plus/view/screen/residence_details/inner_widget/review/review_repo/review_repo.dart';
import 'package:resid_plus/view/screen/residence_details/inner_widget/review/reviews.dart';
import 'package:resid_plus/view/widgets/text/custom_text.dart';

class ResidenceDetails extends StatefulWidget {
  const ResidenceDetails({super.key});

  @override
  State<ResidenceDetails> createState() => _ResidenceDetailsState();
}

class _ResidenceDetailsState extends State<ResidenceDetails> {

  late List<Residences> allHotelDataList;
  late int index;

  @override
  void initState() {
    allHotelDataList = Get.arguments[0];
    index = Get.arguments[1];

    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(ReviewRepo(apiService: Get.find()));
    var controller = Get.put(ReviewController(reviewRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.review(id: allHotelDataList[index].id.toString());
    });

    DeviceUtils.innerUtils();
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.bottomNavUtils();
    super.dispose();
  }

  int currentIndex = 0;

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
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back_ios,
                        color: AppColors.blackPrimary, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "residenceDetails".tr,
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF333333),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            )),
        body: GetBuilder<ReviewController>(
          builder: (controller) => controller.isLoading
              ? const Center(
                  child:
                      CircularProgressIndicator(color: AppColors.blackPrimary),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: 20, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CarouselSlider.builder(
                            itemCount: allHotelDataList[index].photo?.length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                    int pageIndex) =>
                                Container(
                              margin:
                                  const EdgeInsets.only(right: 10, left: 10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(allHotelDataList[index]
                                          .photo![itemIndex].publicFileUrl
                                          .toString())),
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
                              height: MediaQuery.of(context).size.height*0.4,
                              autoPlay: true,
                            ),
                          ),
                          const SizedBox(height: 10),
                          DotsIndicator(
                            decorator: DotsDecorator(
                              color: Colors.grey.withOpacity(0.2),
                              activeColor: AppColors.blackPrimary,
                            ),
                            dotsCount: allHotelDataList[index].photo?.length ?? 0,
                            position: currentIndex,
                          )
                        ],
                      ),


                      const SizedBox(height: 4),

                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CustomText(text: "Likes  " ,),
                              CustomText(text: "(${allHotelDataList[index].likes.toString()})",),
                            ],
                          ),
                          Row(
                            children: [
                              const CustomText(text: "Views  ",),
                              CustomText(text: "(${allHotelDataList[index].views.toString()})",),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        allHotelDataList[index].residenceName ?? '---',
                                        style: GoogleFonts.raleway(
                                          color: const Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),

                                    const Icon(Icons.star, color: Color(0xFFFBA91D), size: 18),
                                    const SizedBox(width: 4),
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '(',
                                            style: GoogleFonts.raleway(
                                              color: const Color(0xFF333333),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "${allHotelDataList[index].ratings ?? 0}",
                                            style: GoogleFonts.openSans(
                                              color: const Color(0xFF333333),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ')',
                                            style: GoogleFonts.raleway(
                                              color: const Color(0xFF333333),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                alignment: Alignment.center,
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: allHotelDataList[index].status == "active" ? const Color(0xFFE8EDE6) : const Color(0xFFF2E1E3),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                ),
                                child: Text(
                                  allHotelDataList[index].status.toString(),
                                  style: GoogleFonts.raleway(
                                    color: allHotelDataList[index].status == "active" ? const Color(0xFF6AA259) : const Color(0xFFD7263D),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    const Icon(Icons.place_outlined,
                                        color: Color(0xFF818181), size: 18),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        allHotelDataList[index].city ?? "",
                                        style: GoogleFonts.raleway(
                                          color: const Color(0xFF818181),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                             const SizedBox(width: 20),
                              //hour /day
                              Row(
                                children: [
                                  Text(
                                    "${allHotelDataList[index].hourlyAmount} ${"FCFA /hr".tr}",
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF818181),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "${allHotelDataList[index].dailyAmount} ${"FCFA /day".tr}",
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF818181),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          ImageWithNumber(imageName: "assets/icons/user_group.svg", number: "${allHotelDataList[index].capacity ?? 0}"),
                          ImageWithNumber(
                              imageName: "assets/icons/bed.svg",
                              number: "${allHotelDataList[index].beds ?? 0}"
                          ),
                          ImageWithNumber(
                              imageName: "assets/icons/shower.svg",
                              number: "${allHotelDataList[index].baths ?? 0}"
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'city'.tr,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF818181),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 2,
                              ),
                              Text(
                                allHotelDataList[index].city ?? "",
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF818181),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'municipality'.tr,
                                  style: GoogleFonts.raleway(
                                    color: const Color(0xFF818181),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  allHotelDataList[index].municipality ?? "",
                                  style: GoogleFonts.raleway(
                                    color: const Color(0xFF818181),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'quartar'.tr,
                                style: GoogleFonts.raleway(
                                  color: const Color(0xFF818181),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                allHotelDataList[index].quirtier ?? "",
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
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'aboutResidence'.tr,
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF333333),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            allHotelDataList[index].aboutResidence ?? "",
                            style: GoogleFonts.raleway(
                              color: const Color(0xFF818181),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      GetBuilder<ReviewController>(builder: (controller) {
                        var data = controller.reviewModel.data?.attributes;
                        return controller.reviewData.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 24),
                                  Text(
                                    'Top Reviews',
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF333333),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                        data?.length ?? 0,
                                        (index) => Reviews(
                                            ratting: "${data![index].rating ?? 0}",
                                            userName: data[index].userId?.fullName ?? "---",
                                            date: DateConverter.dateAndMonth("${data[index].createdAt ?? ""}")
                            )
                          ),
                        ),
                      ],
                    ) : const SizedBox();
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
