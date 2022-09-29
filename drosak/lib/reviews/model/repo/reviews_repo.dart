import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../utils/firestore_names.dart';
import '../entity/review.dart';

class ReviewsRepo {
  Stream<QuerySnapshot<Review>> getReviews(String teacherId, String orderBy) {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(teacherId)
        .collection(FireStoreNames.collectionTeacherReviews)
        .withConverter<Review>(
          fromFirestore: (snapshot, _) => Review.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy(orderBy, descending: true)
        .snapshots();
  }

  Future<void> addReview(Review review) async {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(review.teacherId)
        .collection(FireStoreNames.collectionTeacherReviews)
        .withConverter<Review>(
            fromFirestore: (snapshot, _) => Review.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(review);
  }
}
