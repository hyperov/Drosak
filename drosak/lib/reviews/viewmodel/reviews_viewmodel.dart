import 'package:drosak/teachers/model/teacher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/firestore_names.dart';
import '../../utils/storage_keys.dart';
import '../model/entity/review.dart';
import '../model/repo/reviews_repo.dart';

class ReviewsViewModel extends GetxController {
  final ReviewsRepo _reviewsRepo = Get.put(ReviewsRepo());

  final RxList<Review> reviews = <Review>[].obs;

  RxBool isLoading = false.obs;

  final _storage = GetStorage();

  final orderBy = FireStoreNames.collectionTeacherReviewsSortFieldDate.obs;

  var addedReviewTextController = TextEditingController();

  double rating = 5.0;

  @override
  onReady() async {
    super.onReady();
    isLoading.value = true;
    await getReviews();
    ever(orderBy, (callback) => getReviews());
  }

  getReviews() async {
    String? teacherId = _storage.read<String>(StorageKeys.teacherId);

    var _localReviews =
        await _reviewsRepo.getReviews(teacherId!, orderBy.value);

    var reviewsDocs = _localReviews.docs.map((doc) {
      return doc.data();
    });
    isLoading.value = false;
    reviews.clear();
    reviews.addAll(reviewsDocs);
  }

  @override
  void dispose() {
    super.dispose();
    addedReviewTextController.dispose();
  }

  Future<void> reviewTeacher(Teacher teacher) async {
    final review = Review(
        teacherId: teacher.id!,
        rating: rating,
        body: addedReviewTextController.text,
        date: DateTime.now());

    await _reviewsRepo.addReview(review);
    addedReviewTextController.clear();
  }
}
