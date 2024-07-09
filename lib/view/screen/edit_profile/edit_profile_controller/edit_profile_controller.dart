import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:resid_plus/core/global/api_url_container.dart';
import 'package:resid_plus/core/helper/shear_preference_helper.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/profile/profile_controller/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileController extends GetxController {
  EditProfileController();
  File? imageFile;
  List<File> addImages = [];
  bool isLoading = false;
  var profileController = Get.find<ProfileController>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 60);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      addImages.add(imageFile!);

      update();
    }
  }

  void openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxHeight: 120, maxWidth: 120);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      update();
    }
  }

  bool isSubmit = false;

  Future<void> updateUserInfo() async {
    isSubmit = true;
    update();

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(SharedPreferenceHelper.accessTokenKey);

    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse("${ApiUrlContainer.baseUrl}${ApiUrlContainer.updateUser}"),
      );

      if (imageFile != null) {
        var mimeType = lookupMimeType(imageFile!.path);
        var multipartImg = await http.MultipartFile.fromPath(
          'image',
          imageFile!.path,
          contentType: MediaType.parse(mimeType!),
        );
        request.files.add(multipartImg);
      }

      // Add the parameters to the request
      Map<String, dynamic> params = {
        "fullName": nameController.text,
        "email": emailController.text,
        "phoneNumber": numberController.text,
        "address": addressController.text,
      };

      params.forEach((key, value) {
        request.fields[key] = value;
      });

      request.headers['Content-Type'] = 'multipart/form-data';
      request.headers['Authorization'] = "Bearer $token";

      // Send the request
      var response = await request.send();

      if (response.statusCode == 201) {
        profileController.profile();
        Utils.toastMessage("Successfully profile updated".tr);
        Get.back();
        print(response.statusCode);
      } else if (response.statusCode == 503) {
        Utils.toastMessage("Somethings went wrong");
      } else if (response.statusCode == 413) {
        Utils.toastMessage("Image file too Large".tr);
      } else if (response.statusCode == 403) {
        Utils.toastMessage("Invalid phone number".tr);
      }
    } catch (e) {
      Utils.toastMessage("Somethings went wrong $e");
    }

    isSubmit = false;
    update();
  }
}
