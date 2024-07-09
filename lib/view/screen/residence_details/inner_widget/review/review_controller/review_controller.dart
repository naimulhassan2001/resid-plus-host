import 'dart:convert';
import 'package:get/get.dart';
import 'package:resid_plus/core/global/api_response_model.dart';
import 'package:resid_plus/view/screen/residence_details/inner_widget/review/review_model/review_model.dart';
import 'package:resid_plus/view/screen/residence_details/inner_widget/review/review_repo/review_repo.dart';

class ReviewController extends GetxController {
  ReviewRepo reviewRepo;
  ReviewController({required this.reviewRepo});

  ReviewModel reviewModel = ReviewModel();

  bool isLoading = false;

  List<Attribute> reviewData = [];

  Future<void> review({required String id}) async {
    isLoading = true;
    update();
    ApiResponseModel responseModel = await reviewRepo.reviewRepo(id: id);

    if (responseModel.statusCode == 200) {
      reviewModel =
          ReviewModel.fromJson(jsonDecode(responseModel.responseJson));

      List<Attribute>? data = reviewModel.data!.attributes;

      reviewData.addAll(data!);
    } else {}

    isLoading = false;
    update();
  }
}
