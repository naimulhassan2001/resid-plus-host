import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_static_strings.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/add_residence/add_residence_controller/add_residence_controller.dart';
import 'package:resid_plus/view/screen/settings/languages_change/lang_controller/language_controller.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_button.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_loading_button.dart';
import 'package:resid_plus/view/widgets/custom_text_field/custom_field.dart';
import 'package:resid_plus/view/widgets/custom_text_field/custom_text_field.dart';

class AddResidenceOwnerScreen extends StatefulWidget {
  final bool isUpdate;
  final String title;
  final String id;
  const AddResidenceOwnerScreen({super.key, required this.isUpdate, required this.title, required this.id});

  @override
  State<AddResidenceOwnerScreen> createState() =>
      _AddResidenceOwnerScreenState();
}

class _AddResidenceOwnerScreenState extends State<AddResidenceOwnerScreen> {
  // List<String> categoryList = ["Hotel", "Residence", "Personal-house"];
  // List<String> selectedAmenitiesList = [];
  // int selectedAmenities = 0;


  @override
  void initState(){
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(LanguageController()).initStorage();
    final controller = Get.put(AddUpdateResidenceController(apiService: Get.find()));
    DeviceUtils.innerUtils();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchAmenities();
      controller.fetchCategory();
    });

    super.initState();
  }
  
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      top: false,
      bottom: false,
      child: GetBuilder<AddUpdateResidenceController>(
          builder: (controller) => Scaffold(
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
                            const Icon(Icons.arrow_back_ios, color: AppColors.blackPrimary, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              widget.title,
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
                body: controller.isLoading ? const Center(
                  child: CircularProgressIndicator(color: AppColors.blackPrimary),
                ) : SingleChildScrollView(
                  padding: const EdgeInsetsDirectional.symmetric(
                      vertical: 24, horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  child: GetBuilder<AddUpdateResidenceController>(
                      builder: (controller) {
                    return Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              maxLines: 6,
                              textInputAction: TextInputAction.next,
                              textEditingController:
                                  controller.aboutResidenceController,
                              title: "aboutResidence".tr,
                              hintText: "Enter about residence".tr,
                              validator: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return "Enter about residence".tr;
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            if (widget.isUpdate == false)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  Text(
                                    'setCategory'.tr,
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF333333),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    addAutomaticKeepAlives: true,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.categoryList.length,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio:
                                        MediaQuery.of(context).size.width,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 8,
                                        mainAxisExtent: 40),
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () => controller.changeCategory(index),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 18,
                                                  height: 18,
                                                  padding: const EdgeInsetsDirectional.all(0.5),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.whiteColor,
                                                      border: Border.all(
                                                          color: AppColors.black20,
                                                          width: 1
                                                      ),
                                                      shape: BoxShape.circle
                                                  ),
                                                  child: Container(
                                                    width: 18,
                                                    height: 18,
                                                    decoration: BoxDecoration(
                                                        color: index == controller.selectedCategory ? AppColors.blackPrimary : AppColors.whiteColor,
                                                        shape: BoxShape.circle
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Flexible(
                                                  child: Text(
                                                    Get.find<LanguageController>().language.val
                                                        ? controller.categoryList[index].translation?.en ?? "---"
                                                        : controller.categoryList[index].translation?.fr ?? "---",
                                                    style: GoogleFonts.raleway(
                                                      color: const Color(0xFF333333),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "setAmount".tr,
                                  style: GoogleFonts.raleway(
                                      color: AppColors.blackPrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child:controller.selectedCategory==0? CustomField(
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value == null ||
                                                value.toString().isEmpty) {
                                              return "enter  hours amount".tr;
                                            }
                                          },
                                          textInputType: TextInputType.number,
                                          controller:
                                          controller.hourlyAmountController,
                                          isLabel: false,
                                          hintText: "\$00 / hr".tr): CustomField(
                                          textInputAction: TextInputAction.next,
                                          validator: (value) {
                                            if (value == null ||
                                                value.toString().isEmpty) {
                                              return "enter  hours amount".tr;
                                            }
                                          },
                                          textInputType: TextInputType.number,
                                          controller:
                                              controller.hourlyAmountController,
                                          isLabel: false,
                                          hintText: "\$00 / Half-day".tr),
                                    ),
                                    const SizedBox(width: 8),
                                    Flexible(
                                      child: CustomField(
                                          textInputAction: TextInputAction.next,
                                          textInputType: TextInputType.number,
                                          controller:
                                              controller.dailyAmountController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.toString().isEmpty) {
                                              return "Enter daily amount".tr;
                                            }
                                          },
                                          isLabel: false,
                                          hintText: "\$00 / day".tr),
                                    )
                                  ],
                                )
                              ],
                            ),

                            if (widget.isUpdate == false)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  Text(
                                    textAlign: TextAlign.start,
                                    'setAminities'.tr,
                                    style: GoogleFonts.raleway(
                                      color: const Color(0xFF333333),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    addAutomaticKeepAlives: true,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.amenityList.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: MediaQuery.of(context).size.width,
                                        crossAxisSpacing: 12,
                                        mainAxisSpacing: 8,
                                        mainAxisExtent: 40
                                    ),
                                    itemBuilder: (context, index) => InkWell(
                                      onTap: () {

                                        setState(() {
                                          String selectedAmenity = controller.amenityList[index].translation?.en ?? "";
                                          if (controller.selectedAmenitiesList.contains(selectedAmenity)) {
                                              controller.selectedAmenitiesList.remove(selectedAmenity);
                                              // controller.changeAminities(index);
                                          } else {
                                            controller.selectedAmenitiesList.add(selectedAmenity);
                                          }
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 18,
                                                  height: 18,
                                                  padding:
                                                  const EdgeInsetsDirectional.all(0.5),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.whiteColor,
                                                    border: Border.all(
                                                      color: AppColors.black20,
                                                      width: 1,
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Container(
                                                    width: 18,
                                                    height: 18,
                                                    decoration: BoxDecoration(
                                                      color: controller.selectedAmenitiesList.contains(
                                                          controller.amenityList[index].translation?.en ?? ""
                                                      ) ? AppColors.blackPrimary : AppColors.whiteColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Flexible(
                                                  child: Text(
                                                    Get.find<LanguageController>().language.val
                                                        ? controller.amenityList[index].translation?.en ?? "---"
                                                        : controller.amenityList[index].translation?.fr ?? "---",
                                                    style: GoogleFonts.raleway(
                                                      color:
                                                      const Color(0xFF333333),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            const SizedBox(height: 24),
                            Text(
                              "ownerInformation".tr,
                              style: GoogleFonts.raleway(
                                  fontSize: 18,
                                  color: AppColors.blackPrimary,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null ||
                                      value.toString().isEmpty) {
                                    return "Please enter your name".tr;
                                  }
                                },
                                textEditingController:
                                    controller.ownerNameController,
                                title: "ownerName".tr,
                                hintText: "Enter name".tr),
                            const SizedBox(height: 12),
                            CustomTextField(
                              textInputAction: TextInputAction.done,
                              textEditingController:
                                  controller.ownerAboutController,
                              validator: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return "Please write about yourself".tr;
                                }
                              },
                              title: "about".tr,
                              hintText: "About yourself".tr,
                              maxLines: 6,
                            ),
                          ],
                        ));
                  }),
                ),
                bottomNavigationBar: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsetsDirectional.only(
                      start: 20, end: 20, bottom: 24, top: 24),
                  child: controller.isSubmit
                      ? const CustomElevatedLoadingButton(
                          buttonColor: AppColors.blackPrimary,
                        )
                      : CustomElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.addMultipleImageAndParams(id: widget.isUpdate ? "/${widget.id}" : "");
                            }
                          },
                          titleText: widget.isUpdate ? AppStaticStrings.update : "add".tr,
                          buttonWidth: MediaQuery.of(context).size.width,
                        ),
                ),
              )),
    );
  }
}
