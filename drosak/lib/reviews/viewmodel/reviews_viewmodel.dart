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
}
