import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/add_residence/add_residence_controller/add_residence_controller.dart';
import 'package:resid_plus/view/screen/add_residence/add_update_residence_screen.dart';
import 'package:resid_plus/view/screen/my_residence/inactive_repo/inactive_repo.dart';
import 'package:resid_plus/view/screen/my_residence/inner_widgets/alert_box.dart';
import 'package:resid_plus/view/screen/my_residence/my_residence_controller/my_residence_controller.dart';
import 'package:resid_plus/view/screen/my_residence/my_residence_repo/my_residence_repo.dart';
import 'package:resid_plus/view/widgets/custom_text_field/custom_search_field.dart';

class MyResidenceScreen extends StatefulWidget {
  const MyResidenceScreen({super.key});

  @override
  State<MyResidenceScreen> createState() => _MyResidenceScreenState();
}

class _MyResidenceScreenState extends State<MyResidenceScreen> {
  @override
  void initState() {
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(MyResidenceRepo(apiService: Get.find()));

    var myResidenceController = Get.put(MyResidenceController(myResidenceRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      myResidenceController.myResidence(search: "");
    });

    DeviceUtils.innerUtils();
    super.initState();
  }

  @override
  void dispose() {
    DeviceUtils.bottomNavUtils();
    super.dispose();
  }

  var addResidenceController = Get.put(AddUpdateResidenceController(apiService: Get.find()));

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
              child: Row(
                children: [
                  IconButton(
                      highlightColor: Colors.transparent,
                      onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18)),

                  Text(
                    "myResindence".tr,
                    style: GoogleFonts.raleway(
                      color: const Color(0xFF333333),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            )),
        body: GetBuilder<MyResidenceController>(builder: (controller) {
          print("==========${controller.myResidenceList.length}");
          if (controller.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }

          return LayoutBuilder(
            builder: (context, BoxConstraints constraints) {
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 24),
                    child: CustomSearchField(
                      onChanged: (value) {
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            controller.myResidence(
                                search: "&search=${controller.searchEditingController.text}");
                          },
                        );
                      },
                      controller: controller.searchEditingController,
                    ),
                  ),
                  Expanded(
                    child: controller.myResidenceList.isNotEmpty ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                          height: MediaQuery.of(context).size.height/1.5,
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 20),
                              // controller: controller.residenceController ,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.isLoading?controller.myResidenceList.length +1 : controller.myResidenceList.length,
                                itemBuilder: (context,index){
                              final data = controller.myResidenceList[index];
                              String status = controller.myResidenceList[index].status.toString();
                              if(index<controller.myResidenceList.length){
                                return  GestureDetector(
                                  onTap: (){
                                    if(data.acceptanceStatus=="accepted" && data.status == "active"){
                                      Get.toNamed(AppRoute.residenceDetails, arguments: [controller.myResidenceList, index]);
                                    }
                                    if(data.acceptanceStatus=="accepted" && data.status == "reserved"){
                                      Get.toNamed(AppRoute.residenceDetails, arguments: [controller.myResidenceList, index]);
                                    }
                                    else if(data.acceptanceStatus=="accepted" && data.status == "inactive"){
                                      Get.toNamed(AppRoute.residenceDetails, arguments: [controller.myResidenceList, index]);
                                    }
                                    else if (data.acceptanceStatus=="pending"){
                                      Utils.toastMessage("Please wait for admin approval".tr);
                                    }
                                    else if (data.acceptanceStatus=="blocked"){
                                      showDialog(context: context, builder: (BuildContext  context){
                                        return Dialog(
                      
                                          child: Padding(
                                            padding: const EdgeInsets.all(24.0),
                                            child: Text(
                                              data.feedBack,style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                              textAlign:TextAlign.center,
                                            ),
                                          ),
                                        );
                                      });
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 300,
                                          padding: const EdgeInsetsDirectional.only(top: 4, end: 4),
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(controller
                                                  .myResidenceList[index]
                                                  .photo![0]
                                                  .publicFileUrl
                                                  .toString()),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8)),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      controller.myResidenceList[index].residenceName ?? "---",
                                                      style: GoogleFonts.raleway(
                                                        color: AppColors
                                                            .blackPrimary,
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                    const SizedBox(width: 16,),
                                                    Row(
                                                      children: [
                                                        const Icon(Icons.star,
                                                            color: Color(0xFFFBA91D),
                                                            size: 18
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
                                                                text: controller.myResidenceList[index].popularity
                                                                    .toString(),
                                                                style: GoogleFonts
                                                                    .openSans(
                                                                  color: AppColors
                                                                      .blackPrimary,
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
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  padding:const EdgeInsets.symmetric(
                                                      horizontal: 12, vertical: 6),
                                                  alignment: Alignment.center,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: ShapeDecoration(
                                                    color: data.acceptanceStatus== "accepted" ? const Color(0xFFE8EDE6) :  const Color(0xFFF2E1E3),
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                  ),
                                                  child: Text(
                                                    data.acceptanceStatus == "accepted"&& data.status == "active"? data.acceptanceStatus.toString() :
                                                    data.acceptanceStatus =="accepted" && data.status == "inactive"? data.status.toString():
                                                    data.acceptanceStatus == "pending"?data.acceptanceStatus.toString() :
                                                    data.acceptanceStatus == "blocked"?data.acceptanceStatus.toString():
                                                    data.acceptanceStatus == "accepted"&& data.status == "reserved"? data.status.toString():"",
                                                    style: GoogleFonts.raleway(
                                                      color: data.acceptanceStatus == "accepted" ? const Color(0xFF6AA259) : const Color(0xFFD7263D),
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.40,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            status == "active" ? const SizedBox(height: 8) : const SizedBox(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SvgPicture.asset("assets/icons/location.svg"),
                                                      const SizedBox(width: 4),
                                                      Expanded(
                                                        child: Text(
                                                          controller.myResidenceList[index].address ?? "",
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: GoogleFonts.raleway(
                                                            color:
                                                            const Color(0xFF818181),
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                status != "reserved" ? PopupMenuButton(
                                                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 4, vertical: 2),
                                                  position: PopupMenuPosition.under,
                                                  offset: const Offset(-15, -15),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: const BoxDecoration(
                                                        color: AppColors.transparentColor,
                                                        shape: BoxShape.circle
                                                    ),
                                                    child: const Icon(
                                                        Icons.more_horiz_outlined,
                                                        color: AppColors.blackPrimary,
                                                        size: 18
                                                    ),
                                                  ),
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem(
                                                          onTap: () {
                                                            //Image
                                                            addResidenceController.selectedImages.clear();
                                                            addResidenceController.selectedImagesOnline.clear();
                      
                                                            for (var img in data.photo!) {
                                                              addResidenceController.selectedImagesOnline.add(img.publicFileUrl.toString());
                                                            }
                      
                                                            addResidenceController.selectedImagesOnline.add(data.photo![index].publicFileUrl.toString());
                      
                                                            //Name
                                                            addResidenceController.residenceNameController =
                                                                TextEditingController(
                                                                    text: data.residenceName.toString());
                      
                                                            //Capacity
                      
                                                            addResidenceController.personCapacityController =
                                                                TextEditingController(text: data.capacity.toString());
                      
                                                            //beds
                                                            addResidenceController.bedsController =
                                                                TextEditingController(text: data.beds.toString());
                      
                                                            //baths
                                                            addResidenceController.bathController =
                                                                TextEditingController(text: data.baths.toString());
                      
                                                            //address
                                                            addResidenceController.addressController =
                                                                TextEditingController(text: data.address.toString());
                      
                                                            //city
                      
                                                            addResidenceController
                                                                .cityController = TextEditingController(text: data.city.toString());
                      
                                                            //municipality
                      
                                                            addResidenceController
                                                                .manucityController =
                                                                TextEditingController(text: data.municipality.toString());
                                                            //quirtier
                      
                                                            addResidenceController.quarterController =
                                                                TextEditingController(text: data.quirtier.toString());
                      
                                                            //aboutResidence
                      
                                                            addResidenceController.aboutResidenceController =
                                                                TextEditingController(text: data.aboutResidence.toString());
                      
                                                            //hourlyAmount
                      
                                                            addResidenceController
                                                                .hourlyAmountController =
                                                                TextEditingController(
                                                                    text: data
                                                                        .hourlyAmount
                                                                        .toString());
                      
                                                            //dailyAmount
                      
                                                            addResidenceController
                                                                .dailyAmountController =
                                                                TextEditingController(
                                                                    text: data
                                                                        .dailyAmount
                                                                        .toString());
                      
                                                            //ownerName
                      
                                                            addResidenceController
                                                                .ownerNameController =
                                                                TextEditingController(
                                                                    text: data.ownerName.toString());
                      
                                                            //aboutOwner
                      
                                                            addResidenceController.ownerAboutController =
                                                                TextEditingController(text: data.aboutOwner.toString());
                      
                                                            //Route
                                                            Get.to(() =>
                                                                AddUpdateResidence(id: controller.myResidenceModel.data!.attributes!.residences![
                                                                  index].id.toString(), title:
                                                                  "Update Residence".tr,
                                                                  isUpdate:
                                                                  true,
                                                                ));
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            children: [
                                                              SvgPicture.asset(
                                                                  "assets/icons/edit.svg"),
                                                              const SizedBox(
                                                                  width: 8),
                                                              Text(
                                                                "Edit".tr,
                                                                textAlign:
                                                                TextAlign
                                                                    .center,
                                                                style: GoogleFonts.raleway(
                                                                    color: AppColors
                                                                        .blackPrimary,
                                                                    fontSize:
                                                                    14,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                              ),
                                                            ],
                                                          )),
                                                      PopupMenuItem(
                                                        onTap: () {
                                                          showDialog<void>(
                                                            context: context,
                                                            barrierDismissible:
                                                            false, // user must tap button!
                                                            builder:
                                                                (BuildContext
                                                            context) {
                                                              return AlertBox(
                                                                id: controller
                                                                    .myResidenceModel
                                                                    .data!
                                                                    .attributes!
                                                                    .residences![
                                                                index]
                                                                    .id
                                                                    .toString(),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            SvgPicture.asset(
                                                                "assets/icons/delete.svg"),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              "Delete".tr,
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                              style: GoogleFonts.raleway(
                                                                  color: AppColors
                                                                      .redPrimary,
                                                                  fontSize:
                                                                  14,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        onTap: () {
                                                          String id= controller.myResidenceModel.data!.attributes!.residences![index].id.toString();
                                                          String status =controller.myResidenceModel.data!.attributes!.residences![index].status.toString() ;
                                                          var repo = InactiveController(apiService: Get.find());
                                                          print(status);
                                                          if(status=="active"){
                                                            repo.inActiveResidence(id: id, type:Status.inactive);
                                                          }
                                                          else{
                                                            repo.inActiveResidence(id: id, type:Status.active);
                                                          }
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            // SvgPicture.asset(
                                                            //     "assets/icons/delete.svg"),
                                                            Icon(Icons.pause_circle_outline_sharp,color: data.status=="inactive"?AppColors.redPrimary: AppColors.blackPrimary ,),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(data.status.toString(),
                                                              textAlign: TextAlign.center,
                                                              style: GoogleFonts.raleway(color:data.status=="inactive"?AppColors.redPrimary:AppColors.blackPrimary, fontSize: 14,
                                                                  fontWeight: FontWeight.w500),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ];
                                                  },
                                                ) : const SizedBox()
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }else{
                                const Center(child: CircularProgressIndicator(),);
                              }
                            }),
                          )
                        ]
                        /*List.generate(controller.isLoading
                      ? controller.myResidenceList.length + 1
                                           : controller.myResidenceList.length,(index) {
                          final data = controller.myResidenceList[index];
                          String status = controller.myResidenceList[index].status.toString();
                            return GestureDetector(
                              onTap: (){
                                if(data.acceptanceStatus=="accepted" && data.status == "active"){
                                  Get.toNamed(AppRoute.residenceDetails, arguments: [controller.myResidenceList, index]);
                                }
                                if(data.acceptanceStatus=="accepted" && data.status == "reserved"){
                                  Get.toNamed(AppRoute.residenceDetails, arguments: [controller.myResidenceList, index]);
                                }
                                else if(data.acceptanceStatus=="accepted" && data.status == "inactive"){
                                  Get.toNamed(AppRoute.residenceDetails, arguments: [controller.myResidenceList, index]);
                                }
                                else if (data.acceptanceStatus=="pending"){
                                  Utils.toastMessage("Please wait for admin approval".tr);
                                }
                                else if (data.acceptanceStatus=="blocked"){
                                  showDialog(context: context, builder: (BuildContext  context){
                                    return Dialog(
                      
                                      child: Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: Text(
                      
                                          data.feedBack,style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                          textAlign:TextAlign.center,
                                        ),
                                      ),
                                    );
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 300,
                                      padding: const EdgeInsetsDirectional.only(top: 4, end: 4),
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(controller
                                              .myResidenceList[index]
                                              .photo![0]
                                              .publicFileUrl
                                              .toString()),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8)),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  controller.myResidenceList[index].residenceName ?? "---",
                                                  style: GoogleFonts.raleway(
                                                    color: AppColors
                                                        .blackPrimary,
                                                    fontSize: 14,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                                const SizedBox(width: 16,),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.star,
                                                        color: Color(0xFFFBA91D),
                                                        size: 18
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
                                                            text: controller.myResidenceList[index].popularity
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .openSans(
                                                              color: AppColors
                                                                  .blackPrimary,
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
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding:const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 6),
                                              alignment: Alignment.center,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: ShapeDecoration(
                                                color: data.acceptanceStatus== "accepted" ? const Color(0xFFE8EDE6) :  const Color(0xFFF2E1E3),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                              ),
                                              child: Text(
                                                data.acceptanceStatus == "accepted"&& data.status == "active"? data.acceptanceStatus.toString() :
                                                data.acceptanceStatus =="accepted" && data.status == "inactive"? data.status.toString():
                                                data.acceptanceStatus == "pending"?data.acceptanceStatus.toString() :
                                                data.acceptanceStatus == "blocked"?data.acceptanceStatus.toString():
                                                data.acceptanceStatus == "accepted"&& data.status == "reserved"? data.status.toString():"",
                                                style: GoogleFonts.raleway(
                                                  color: data.acceptanceStatus == "accepted" ? const Color(0xFF6AA259) : const Color(0xFFD7263D),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.40,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        status == "active" ? const SizedBox(height: 8) : const SizedBox(),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SvgPicture.asset("assets/icons/location.svg"),
                                                  const SizedBox(width: 4),
                                                  Expanded(
                                                    child: Text(
                                                      controller.myResidenceList[index].address ?? "",
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: GoogleFonts.raleway(
                                                        color:
                                                        const Color(0xFF818181),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            status != "reserved" ? PopupMenuButton(
                                              padding: const EdgeInsetsDirectional.symmetric(horizontal: 4, vertical: 2),
                                              position: PopupMenuPosition.under,
                                              offset: const Offset(-15, -15),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: const BoxDecoration(
                                                    color: AppColors.transparentColor,
                                                    shape: BoxShape.circle
                                                ),
                                                child: const Icon(
                                                    Icons.more_horiz_outlined,
                                                    color: AppColors.blackPrimary,
                                                    size: 18
                                                ),
                                              ),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                      onTap: () {
                                                        //Image
                      
                                                        addResidenceController
                                                            .selectedImages
                                                            .clear();
                      
                                                        addResidenceController
                                                            .selectedImagesOnline
                                                            .clear();
                      
                                                        for (var img
                                                        in data
                                                            .photo!) {
                                                          addResidenceController
                                                              .selectedImagesOnline
                                                              .add(img
                                                              .publicFileUrl
                                                              .toString());
                                                        }
                      
                                                        addResidenceController
                                                            .selectedImagesOnline
                                                            .add(data
                                                            .photo![
                                                        index]
                                                            .publicFileUrl
                                                            .toString());
                      
                                                        //Name
                                                        addResidenceController
                                                            .residenceNameController =
                                                            TextEditingController(
                                                                text: data
                                                                    .residenceName
                                                                    .toString());
                      
                                                        //Capacity
                      
                                                        addResidenceController
                                                            .personCapacityController =
                                                            TextEditingController(
                                                                text: data
                                                                    .capacity
                                                                    .toString());
                      
                                                        //beds
                                                        addResidenceController
                                                            .bedsController =
                                                            TextEditingController(
                                                                text: data
                                                                    .beds
                                                                    .toString());
                      
                                                        //baths
                                                        addResidenceController
                                                            .bathController =
                                                            TextEditingController(
                                                                text: data
                                                                    .baths
                                                                    .toString());
                      
                                                        //address
                                                        addResidenceController
                                                            .addressController =
                                                            TextEditingController(
                                                                text: data
                                                                    .address
                                                                    .toString());
                      
                                                        //city
                      
                                                        addResidenceController
                                                            .cityController =
                                                            TextEditingController(
                                                                text: data
                                                                    .city
                                                                    .toString());
                      
                                                        //municipality
                      
                                                        addResidenceController
                                                            .manucityController =
                                                            TextEditingController(
                                                                text: data
                                                                    .municipality
                                                                    .toString());
                                                        //quirtier
                      
                                                        addResidenceController
                                                            .quarterController =
                                                            TextEditingController(
                                                                text: data
                                                                    .quirtier
                                                                    .toString());
                      
                                                        //aboutResidence
                      
                                                        addResidenceController
                                                            .aboutResidenceController =
                                                            TextEditingController(
                                                                text: data
                                                                    .aboutResidence
                                                                    .toString());
                      
                                                        //hourlyAmount
                      
                                                        addResidenceController
                                                            .hourlyAmountController =
                                                            TextEditingController(
                                                                text: data
                                                                    .hourlyAmount
                                                                    .toString());
                      
                                                        //dailyAmount
                      
                                                        addResidenceController
                                                            .dailyAmountController =
                                                            TextEditingController(
                                                                text: data
                                                                    .dailyAmount
                                                                    .toString());
                      
                                                        //ownerName
                      
                                                        addResidenceController
                                                            .ownerNameController =
                                                            TextEditingController(
                                                                text: data
                                                                    .ownerName
                                                                    .toString());
                      
                                                        //aboutOwner
                      
                                                        addResidenceController
                                                            .ownerAboutController =
                                                            TextEditingController(
                                                                text: data
                                                                    .aboutOwner
                                                                    .toString());
                      
                                                        //Route
                                                        Get.to(() =>
                                                            AddUpdateResidence(
                                                              id: controller
                                                                  .myResidenceModel
                                                                  .data!
                                                                  .attributes!
                                                                  .residences![
                                                              index]
                                                                  .id
                                                                  .toString(),
                                                              title:
                                                              "Update Residence".tr,
                                                              isUpdate:
                                                              true,
                                                            ));
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          SvgPicture.asset(
                                                              "assets/icons/edit.svg"),
                                                          const SizedBox(
                                                              width: 8),
                                                          Text(
                                                            "Edit".tr,
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                            style: GoogleFonts.raleway(
                                                                color: AppColors
                                                                    .blackPrimary,
                                                                fontSize:
                                                                14,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                          ),
                                                        ],
                                                      )),
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      showDialog<void>(
                                                        context: context,
                                                        barrierDismissible:
                                                        false, // user must tap button!
                                                        builder:
                                                            (BuildContext
                                                        context) {
                                                          return AlertBox(
                                                            id: controller
                                                                .myResidenceModel
                                                                .data!
                                                                .attributes!
                                                                .residences![
                                                            index]
                                                                .id
                                                                .toString(),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                            "assets/icons/delete.svg"),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          "Delete".tr,
                                                          textAlign:
                                                          TextAlign
                                                              .center,
                                                          style: GoogleFonts.raleway(
                                                              color: AppColors
                                                                  .redPrimary,
                                                              fontSize:
                                                              14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      String id= controller.myResidenceModel.data!.attributes!.residences![index].id.toString();
                                                      String status =controller.myResidenceModel.data!.attributes!.residences![index].status.toString() ;
                                                      var repo = InactiveController(apiService: Get.find());
                                                      print(status);
                                                      if(status=="active"){
                                                        repo.inActiveResidence(id: id, type:Status.inactive);
                                                      }
                                                      else{
                                                        repo.inActiveResidence(id: id, type:Status.active);
                                                      }
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        // SvgPicture.asset(
                                                        //     "assets/icons/delete.svg"),
                                                        Icon(Icons.pause_circle_outline_sharp,color: data.status=="inactive"?AppColors.redPrimary: AppColors.blackPrimary ,),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(data.status.toString(),
                                                          textAlign: TextAlign.center,
                                                          style: GoogleFonts.raleway(color:data.status=="inactive"?AppColors.redPrimary:AppColors.blackPrimary, fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ];
                                              },
                                            ) : const SizedBox()
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                        }),*/
                      ),
                    ): const Center(child: Text("No Data Found",style: TextStyle(fontSize: 20),)),
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
