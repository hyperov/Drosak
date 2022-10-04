import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/teachers/model/teacher.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  late StreamSubscription<QuerySnapshot<Review>> reviewListen;

  @override
  onReady() async {
    super.onReady();
    isLoading.value = true;
    await getReviews();
    ever(orderBy, (callback) => getReviews());
  }

  Future<void> getReviews() async {
    isLoading.value = true;
    String? teacherId = _storage.read<String>(StorageKeys.teacherId);

    var reviewsStream = _reviewsRepo.getReviews(teacherId!, orderBy.value);

    reviewListen = reviewsStream.listen((_reviews) {
      var reviewsDocs = _reviews.docs.map((doc) => doc.data()).toList();
      isLoading.value = false;
      reviews.clear();
      reviews.addAll(reviewsDocs);
    }, onError: (e) {
      isLoading.value = false;
      print(e);
    });
  }

  @override
  void dispose() {
    super.dispose();
    addedReviewTextController.dispose();
    reviewListen.cancel();
  }

  Future<void> reviewTeacher(Teacher teacher) async {
    final review = Review(
        teacherId: teacher.id!,
        rating: rating,
        body: addedReviewTextController.text,
        date: DateTime.now(),
        studentId: FirebaseAuth.instance.currentUser!.uid);

    await _reviewsRepo.addReview(review);
    addedReviewTextController.clear();
  }
}
