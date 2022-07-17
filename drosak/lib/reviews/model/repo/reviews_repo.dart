import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/firestore_names.dart';
import '../entity/review.dart';

class ReviewsRepo {
  Future<QuerySnapshot<Review>> getReviews(
      String teacherId, String orderBy) async {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(teacherId)
        .collection(FireStoreNames.collectionTeacherReviews)
        .withConverter<Review>(
          fromFirestore: (snapshot, _) => Review.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy(orderBy, descending: true)
        .get();
  }

  Future<void> addReview(String teacherId, Review review) async {}
}
