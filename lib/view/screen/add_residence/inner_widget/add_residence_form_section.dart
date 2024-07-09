import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resid_plus/utils/app_colors.dart';
import 'package:resid_plus/view/screen/add_residence/add_residence_controller/add_residence_controller.dart';
import 'package:resid_plus/view/screen/auth/sign_up/contry_model/country_model.dart';
import 'package:resid_plus/view/widgets/custom_text_field/custom_text_field.dart';

class AddResidenceFormSection extends StatefulWidget {

  final String title;
  final bool isUpdate;
  final String id;
  final GlobalKey formKey;
  const AddResidenceFormSection({
    super.key,
    required this.isUpdate,
    required this.title,
    required this.id,
    required this.formKey
  });

  @override
  State<AddResidenceFormSection> createState() => _AddResidenceFormSectionState();
}

class _AddResidenceFormSectionState extends State<AddResidenceFormSection> {
 @override
  void initState() {
    final controller= Get.put(AddUpdateResidenceController(apiService: Get.find()));
    controller.getCountryName();
    super.initState();
  }
 // AddUpdateResidenceController controller= Get.put(AddUpdateResidenceController(apiService: Get.find()));
  @override
  Widget build(BuildContext context) {

    return GetBuilder<AddUpdateResidenceController>(builder: (controller) {
      return Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                title: "residencName".tr,
                hintText: "Enter Residence Name".tr,
                textInputAction: TextInputAction.next,
                textEditingController: controller.residenceNameController,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return "Please write about you".tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              CustomTextField(
                title: "capacityPerson".tr,
                hintText: "Enter person number".tr,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textEditingController: controller.personCapacityController,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return 'Enter person number'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              CustomTextField(
                title: "beds".tr,
                hintText: "Enter how many beds".tr,
                textEditingController: controller.bedsController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return "Enter how many beds".tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              CustomTextField(
                title: "bath".tr,
                hintText: "Enter how many baths".tr,
                textInputAction: TextInputAction.next,
                textEditingController: controller.bathController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return "Enter how many baths".tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),


              //Country selected
               Align(
                alignment: Alignment.centerLeft,
                child: Text("Select Country".tr
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: controller.selectedCountry.toString().isEmpty ? const Color(0xffe2e2e2) : AppColors.black20
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.transparentColor,
                ),
                child: DropdownButton<Attribute>(
                  underline:const SizedBox(),
                  style: GoogleFonts.raleway(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackPrimary
                  ),
                  value: controller.selectedCountry,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: controller.countyName.map<DropdownMenuItem<Attribute>>((Attribute country) {
                    return DropdownMenuItem(
                      value: country,
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child:  CachedNetworkImage(
                              fit: BoxFit.fill,
                              height: 40,
                              width: 40,
                              imageUrl: country.countryFlag?.publicFileUrl ?? "",
                            ),),
                          // You can add any widget you want here
                          const SizedBox(width: 16), // Adjust spacing as needed
                          Text(country.countryName!),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (Attribute? newValue) {
                    setState(() {
                      controller.selectedCountry = newValue!;
                    }
                    );
                  },
                ),
              ),
              const SizedBox(height: 12,),

              //address
              CustomTextField(
                title: "address".tr,
                textInputAction: TextInputAction.next,
                hintText: "Enter residence address".tr,
                textEditingController: controller.addressController,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return "Enter residence address".tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              CustomTextField(
                title: "city".tr,
                hintText: "Enter city name".tr,
                textInputAction: TextInputAction.next,
                textEditingController: controller.cityController,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return "Enter city name".tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              CustomTextField(
                title: "municipality".tr,
                textInputAction: TextInputAction.next,
                hintText: "Enter municipality name".tr,
                textEditingController: controller.manucityController,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return "Enter municipality name".tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              CustomTextField(
                title: "quartar".tr,
                hintText: "Enter quartier".tr,
                textInputAction: TextInputAction.done,
                textEditingController: controller.quarterController,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return "Enter quartier".tr;
                  }
                  return null;
                },
              ),
            ],
          ));
    });
  }
}
