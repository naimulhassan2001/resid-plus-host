import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resid_plus/core/global/api_response_method.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/core/helper/shear_preference_helper.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/service/api_service.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/add_residence/amenities/amenities_model/amenities_model.dart'
    as am;
import 'package:resid_plus/view/screen/add_residence/category/category_model/category_model.dart'
    as cm;
import 'package:resid_plus/view/screen/auth/sign_up/contry_model/country_model.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart';

class AddUpdateResidenceController extends GetxController
    with GetxServiceMixin {
  ApiService apiService;

  AddUpdateResidenceController({required this.apiService});

  TextEditingController personCapacityController = TextEditingController();
  TextEditingController bedsController = TextEditingController();
  TextEditingController bathController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController manucityController = TextEditingController();
  TextEditingController quarterController = TextEditingController();

  // second page params :
  TextEditingController aboutResidenceController = TextEditingController();
  TextEditingController hourlyAmountController = TextEditingController();
  TextEditingController dailyAmountController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerAboutController = TextEditingController();
  TextEditingController residenceNameController = TextEditingController();

  List<File> selectedImages = [];
  List<String> selectedImagesOnline = [];

  List<String> selectedAmenitiesList = [];
  int selectedAmenities = 0;

  final picker = ImagePicker();

  String? imageUrl;
  bool isLoading = false;
  String selectCategory = "";

// get ountry code and name
  Attribute selectedCountry = Attribute();
  List<Attribute> countyName = [];
  CountryModel countryModel = CountryModel();
  getCountryName() async {
    String uri = "${ApiUrlContainer.baseUrl}${ApiUrlContainer.countryEndpoint}";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel =
        await apiService.request(uri, requestMethod, null, passHeader: false);
    debugPrint("========URI $uri");
// return responseModel;
    if (responseModel.statusCode == 200) {
      countryModel =
          CountryModel.fromJson(jsonDecode(responseModel.responseJson));
      countyName = countryModel.data!.attributes!;
      selectedCountry = countyName[0];
      print("====================Humayun Kabir${countyName.length}");
      print("====================Humayun Kabir${countyName}");
      print("====================>${selectedCountry}");
      isLoading = false;
      update();
    } else {
      debugPrint("========URI data not loading");
    }
  }

  void openGallery() async {
    selectedImages.clear();
    update();

    final pickedFile = await picker.pickMultiImage(
      imageQuality: 80, // To set quality of images
    );

    List<XFile> xfilePick = pickedFile;

    if (xfilePick.length > 5) {
      Utils.toastMessage("Pick only 5 images".tr);
      return;
    } else if (xfilePick.length != 5) {
      Utils.toastMessage("Pick 5 images".tr);
    } else if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        if (selectedImages.length < 5) {
          selectedImages.add(File(xfilePick[i].path));
          update();
        } else {
          Utils.toastMessage("You can only select up to 5 images".tr);
          break;
        }
      }
    } else {
      selectedImages.clear();

      Utils.toastMessage("No image selected".tr);
      update();
    }
  }

  bool isSubmit = false;

  Future<void> addMultipleImageAndParams({required String id}) async {
    isSubmit = true;
    update();

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceHelper.accessTokenKey);
    try {
      var request = http.MultipartRequest(
        id == "" ? 'POST' : "PUT",
        Uri.parse(
            "${ApiUrlContainer.baseUrl}${ApiUrlContainer.addResidenceEndPoint}$id"),
      );

      for (var img in selectedImages) {
        // Assuming selectedImages is an array or iterable
        if (img.existsSync()) {
          var mimeType = lookupMimeType(img.path);
          debugPrint("File Type==================$mimeType");
          try {
            var multipartImg = await http.MultipartFile.fromPath(
              'photo',
              img.path,
              contentType: MediaType.parse(mimeType!),
            );
            request.files.add(multipartImg);
          } on Exception catch (error) {
            debugPrint("Error====================$error");
            //
          }
        }
      }

      // Add the parameters to the request
      Map<String, dynamic> params = {
        "capacity": personCapacityController.text,
        "beds": bedsController.text,
        "baths": bathController.text,
        "address": addressController.text,
        "city": cityController.text,
        "municipality": manucityController.text,
        "quirtier": quarterController.text,
        "aboutResidence": aboutResidenceController.text,
        "hourlyAmount": hourlyAmountController.text,
        "dailyAmount": dailyAmountController.text,
        "ownerName": ownerNameController.text,
        "aboutOwner": ownerAboutController.text,
        "residenceName": residenceNameController.text,
        "category": selectCategory,
        "country": selectedCountry.id ?? ""
      };

      debugPrint("=============Country Id :${params.toString()}");
      params.forEach((key, value) {
        request.fields[key] = value;
      });

      for (int i = 0; i < selectedAmenitiesList.length; i++) {
        request.fields['amenities[$i]'] = amenityList[i].id.toString();
      }

      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = "Bearer $token";

      // Send the request
      var response = await request.send();

      if (response.statusCode == 201) {
        Utils.toastMessage(id == ""
            ? "Successfully residence added".tr
            : "Successfully residence updated".tr);

        Get.toNamed(AppRoute.homeScreen);
        clear();
      } else if (response.statusCode == 413) {
        Utils.toastMessage("Image File too large".tr);
      } else if (response.statusCode == 403) {
        Utils.toastMessage("Must provide appropiate data".tr);
      } else {
        Utils.toastMessage("Something went wrong");
      }
    } catch (e) {
      Utils.toastMessage("Somethings went wrong $e");
    }

    clear();
    isSubmit = false;
    update();
  }

  clear() {
    selectedImages = [];
    residenceNameController.clear();
    bedsController.clear();
    personCapacityController.clear();
    bathController.clear();
    addressController.clear();
    cityController.clear();
    manucityController.clear();
    quarterController.clear();
    aboutResidenceController.clear();
    hourlyAmountController.clear();
    dailyAmountController.clear();
    ownerAboutController.clear();
    ownerNameController.clear();
  }

  am.AmenitiesModel amenitiesModel = am.AmenitiesModel();
  List<am.Attributes> amenityList = [];

  Future<void> fetchAmenities() async {
    amenityList.clear();
    isLoading = true;
    update();

    String url =
        "${ApiUrlContainer.baseUrl}${ApiUrlContainer.amenitiesEndPoint}";

    String requestMethod = ApiResponseMethod.getMethod;

    ApiResponseModel responseModel =
        await apiService.request(url, requestMethod, null, passHeader: true);

    if (responseModel.statusCode == 200) {
      amenitiesModel =
          am.AmenitiesModel.fromJson(jsonDecode(responseModel.responseJson));
      List<am.Attributes>? temAmenityList = amenitiesModel.data?.attributes;
      if (temAmenityList != null && temAmenityList.isNotEmpty) {
        amenityList.addAll(temAmenityList);
      }
      print(amenityList);
    }

    isLoading = false;
    update();
  }

  cm.CategoryModel categoryModel = cm.CategoryModel();
  List<cm.Attributes> categoryList = [];

  Future<void> fetchCategory() async {
    categoryList.clear();
    isLoading = true;
    update();
    String url =
        "${ApiUrlContainer.baseUrl}${ApiUrlContainer.categoryEndPoint}";
    String requestMethod = ApiResponseMethod.getMethod;
    ApiResponseModel responseModel =
        await apiService.request(url, requestMethod, null, passHeader: true);

    if (responseModel.statusCode == 200) {
      categoryModel =
          cm.CategoryModel.fromJson(jsonDecode(responseModel.responseJson));
      List<cm.Attributes>? tempList = categoryModel.data?.attributes;

      if (tempList != null && tempList.isNotEmpty) {
        categoryList.addAll(tempList);
      }
    }

    isLoading = false;
    update();
  }

  int selectedCategory = -1;

  changeCategory(int index) {
    selectedCategory = index;
    update();
    selectCategory = categoryList[selectedCategory].id.toString();
    update();
  }

  // changeAminities(int index) {
  //   selectedAminities = index;
  //   update();
  //    selectAminities = amenityList[selectedAminities].id.toString();
  //   update();
  // }

  @override
  void onInit() {
    getCountryName();
    super.onInit();
  }
}
