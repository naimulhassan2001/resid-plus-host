import 'dart:convert';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/core/route/app_route.dart';
import 'package:resid_plus/utils/app_utils.dart';
import 'package:resid_plus/view/screen/profile/profile_model/profile_model.dart';
import 'package:resid_plus/view/screen/profile/profile_repo/profile_repo.dart';

class ProfileController extends GetxController {

  ProfileRepo profileRepo;
  ProfileController({required this.profileRepo});

  bool isLoading = false;

  ProfileModel profileModel = ProfileModel();

  String username = "";
  String email = "";
  String phoneNumber = "";
  String dob = "";
  String address = "";
  String profileImage = "";

  Future<void> profile() async {
    isLoading = true;
    update();

    ApiResponseModel responseModel = await profileRepo.profileRepo();
    if (responseModel.statusCode == 200) {
      profileModel = ProfileModel.fromJson(jsonDecode(responseModel.responseJson));
      username = profileModel.data?.attributes?.user?.fullName ?? "---";
      email = profileModel.data?.attributes?.user?.email ?? "---";
      phoneNumber = profileModel.data?.attributes?.user?.phoneNumber ?? "---";
      dob = profileModel.data?.attributes?.user?.dateOfBirth ?? "---";
      address = profileModel.data?.attributes?.user?.address ?? "---";
      profileImage = profileModel.data?.attributes?.user?.image?.publicFileUrl ?? "---";

    } else if (responseModel.statusCode == 503) {
      Get.offAllNamed(AppRoute.noInternet);
    } else {
      Utils.toastMessage("Something went wrong");
    }

    isLoading = false;
    update();
  }
}
