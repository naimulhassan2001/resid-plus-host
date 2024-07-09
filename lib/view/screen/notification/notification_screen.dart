import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/core/helper/date_converter_helper.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/service/notification.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/home/home_screen.dart';
import 'package:resid_plus/view/screen/notification/notification_controller/notification_controller.dart';
import 'package:resid_plus/view/screen/notification/notification_repo/notification_repo.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    DeviceUtils.innerUtils();

    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(NotificationRepo(apiService: Get.find()), permanent: true);
    final controller = Get.put(NotificationController(notificationRepo: Get.find()), permanent: true);
    WidgetsBinding.instance.addSemanticsEnabledListener(() {
      controller.getNotification();
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
                child: GestureDetector(
                  onTap: () => Get.to(() => const HomeScreen()),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios,
                          color: AppColors.blackPrimary, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        "Notification".tr,
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
          body: GetBuilder<NotificationController>(builder: (controller) {
            return controller.isLoading ?  const Center(child: CircularProgressIndicator(color: AppColors.blackPrimary,),) : controller.dataList.isEmpty ?  Center(
                child: Text(
                    "No Data Found".tr,
                    style: const TextStyle(fontSize: 20))
            ):
            SingleChildScrollView(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 20, vertical: 24),
              child: Column(
                  children: List.generate(
                controller.dataList.length,
                (index) => controller.dataList.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          // NotificationClass notificationClass = NotificationClass();
                          // notificationClass.showNotification("message");
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: const Color(0xff818181))),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: const Color(0xff818181),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            controller.notificationModel.data!.attributes!.allNotification![index].image!.publicFileUrl.toString())),
                                    shape: BoxShape.circle),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.dataList[index].message ?? "",
                                      style: GoogleFonts.raleway(
                                        color: const Color(0xFF333333),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      DateConverter.dateAndMonth(controller
                                          .dataList[index].createdAt
                                          .toString()),
                                      style: GoogleFonts.raleway(
                                        color: const Color(0xFF818181),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/empty.svg"),
                            const SizedBox(height: 24),
                            Text(
                              'No notification available',
                              style: GoogleFonts.raleway(
                                color: const Color(0xFF818181),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
              )),
            );
          })),
    );
  }
}
