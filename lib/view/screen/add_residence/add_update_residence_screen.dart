import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/utils/device_utils.dart';
import 'package:resid_plus/view/screen/add_residence/add_residence_controller/add_residence_controller.dart';
import 'package:resid_plus/view/screen/add_residence/inner_screen/add_residence_owner_screen.dart';
import 'package:resid_plus/view/screen/add_residence/inner_widget/add_residence_form_section.dart';
import 'package:resid_plus/view/screen/add_residence/inner_widget/add_residence_top_section.dart';
import 'package:resid_plus/view/widgets/buttons/custom_button.dart';
import 'package:resid_plus/view/widgets/buttons/custom_elevated_button.dart';

class AddUpdateResidence extends StatefulWidget {
   final String title;
  final String id;
  final bool isUpdate;

  const AddUpdateResidence({
    super.key,
    required this.title,
    required this.isUpdate,
    required this.id,
  });

  @override
  State<AddUpdateResidence> createState() => _AddUpdateResidenceState();
}

class _AddUpdateResidenceState extends State<AddUpdateResidence> {

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    DeviceUtils.innerUtils();
    Get.put(ApiService(sharedPreferences: Get.find()));
    Get.put(AddUpdateResidenceController(apiService: Get.find()));
    super.initState();
  }
  @override
  void dispose() {
    DeviceUtils.bottomNavUtils();
    super.dispose();
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
                onTap: () => Get.back(),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back_ios,
                        color: AppColors.blackPrimary, size: 18),
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
        body: GetBuilder<AddUpdateResidenceController>(builder: (controller) {
          return LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 24, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AddResidenceTopSection(),
                        const SizedBox(height: 24),
                        CustomButton(
                            onTap: () {
                              controller.selectedImagesOnline.clear();
                              controller.openGallery();
                            },
                            title: "uploadPhoto".tr),
                        const SizedBox(height: 24),
                        AddResidenceFormSection(
                          title: widget.title.tr,
                          isUpdate: widget.isUpdate,
                          id: widget.id,
                          formKey: formKey,
                        ),
                      ],
                    ),
                  ));
        }),
        bottomNavigationBar: GetBuilder<AddUpdateResidenceController>(
          builder: (controller) => SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 24),
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: AppColors.whiteColor),
              child: CustomElevatedButton(
                  onPressed: () {
                    if (controller.residenceNameController.text.isEmpty ||
                        controller.personCapacityController.text.isEmpty &&
                            controller.selectedImages.isEmpty) {
                      Utils.toastMessage("Residence name, image and capacity\nmust be provided");
                    } else {
                      if(formKey.currentState!.validate()){
                        Get.to(() => AddResidenceOwnerScreen(
                          id: widget.id,
                          title: widget.title,
                          isUpdate: widget.isUpdate,
                        ));
                      }
                    }
                  },
                  titleText: "continue".tr),
            ),
          ),
        ),
      ),
    );
  }
}
