import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_icons.dart';
import 'package:resid_plus/utils/app_images.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/home/home_residence_controller/home_residence_controller.dart';
import 'package:resid_plus/view/screen/home/home_residence_repo/home_residence_repo.dart';
import 'package:resid_plus/view/screen/home/innter_widgets/drawer.dart';
import 'package:resid_plus/view/screen/home/innter_widgets/home_screen_data.dart';
import 'package:resid_plus/view/screen/home/innter_widgets/home_screen_initial_data.dart';
import 'package:resid_plus/view/screen/notification/notification_screen.dart';
import 'package:resid_plus/view/screen/profile/profile.dart';
import 'package:resid_plus/view/screen/profile/profile_controller/profile_controller.dart';
import 'package:resid_plus/view/screen/profile/profile_repo/profile_repo.dart';
import 'package:resid_plus/view/screen/search/search.dart';
import 'package:resid_plus/view/widgets/app_bar/custom_app_bar.dart';
import 'package:resid_plus/view/widgets/bottom_nav/custom_bottom_nav_bar.dart';
import 'package:resid_plus/view/widgets/design/custom_search.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helper/shear_preference_helper.dart';
import '../../../service/socket_service.dart';
import 'home_notification/controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    DeviceUtils.bottomNavUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiService: Get.find()));
    Get.put(ProfileRepo(apiService: Get.find()));
    final profileController = Get.put(ProfileController(profileRepo: Get.find()));
    final controller = Get.put(HomeController(homeRepo: Get.find()));
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiService: Get.find()));
    final contr = Get.put(EventsController(homeRepo: Get.find(), apiService: Get.find()));


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialState();
      profileController.profile();

    });
    super.initState();
  }
  String userUid = "";
  getNotification() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String userUid = pref.getString(SharedPreferenceHelper.userIdKey).toString();
    Get.find<SocketService>().connectToSocket();
    Get.find<SocketService>().joinRoom(userUid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: GetBuilder<HomeController>(builder: (controller) {
        return Scaffold(
          drawer: const HomeScreenDrawer(),
          key: _scaffoldKey,
          appBar: CustomAppBar(
              appBarContent: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      child: SvgPicture.asset(AppImages.menu),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                          onTap: () => Get.to(() => const SearchScreen()),
                          child: const CustomSearchBar()),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Row(
                children: [
                  GestureDetector(
                      onTap: () => Get.to(() => const NotificationScreen()),
                      child: SvgPicture.asset(AppIcons.bellIcon)),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => Get.to(() => const ProfileScreen()),
                    child: GetBuilder<ProfileController>(builder: (controller) {
                      if (controller.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        );
                      }
                      return Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: controller.profileModel.data!.attributes!.user!.image!.publicFileUrl!.isNotEmpty ? DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(controller.profileModel.data?.attributes?.user?.image?.publicFileUrl ?? ""
                              )
                            ) : const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/profile_image.png")
                            )
                        ),
                      );
                    }),
                  )
                ],
              )
            ],
          )),
          body: GetBuilder<HomeController>(builder: (controller) {
            return controller.isLoading ? const Center(child: CircularProgressIndicator(color: AppColors.blackPrimary,))
                :  controller.allResidencesDataList.isEmpty ? const HomeScreenInitialData() : Column(
                  children: [
                    GetBuilder<EventsController>(
                        builder: (eventsController) {
                          return eventsController.notifiactionList.isNotEmpty?
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(eventsController.isShow?"Hide Events":"Show Events",style: const TextStyle(color: AppColors.blackPrimary,fontWeight: FontWeight.w600),),
                                    IconButton(onPressed: (){
                                      eventsController.check();
                                    },icon: Icon(eventsController.isShow?Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,)),
                                  ],
                                ),
                                eventsController.isLoading? const SizedBox(height: 12,width: 12,child: Center(child: CircularProgressIndicator(strokeWidth: 2,color: AppColors.blackPrimary,))): Visibility(
                                  visible: eventsController.isShow,
                                  child: SizedBox(
                                    height: 180,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: eventsController.notifiactionList.length,itemBuilder: (context, index){
                                      return Container(
                                        margin: const EdgeInsets.only(right: 20),
                                        padding: const EdgeInsets.all(8),
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.grey),
                                          image: DecorationImage(
                                            image:NetworkImage(
                                              eventsController.notifiactionList[index].image?.publicFileUrl.toString()??
                                                  "image Loading",
                                            ) ,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        //child: Text(eventsController.notifiactionList[index].title.toString(),style: const TextStyle(color: AppColors.blackPrimary),),
                                      );

                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ) :SizedBox();
                        }
                    ),

                    const Expanded(child: HomeScreenData()),
                  ],
                );
          }
          ),
          bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
        );
      }),
    );
  }
}
