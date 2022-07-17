import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<void> addReview(Review review) async {
    var batch = FirebaseFirestore.instance.batch();

    var reviewDocRef = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(review.teacherId)
        .collection(FireStoreNames.collectionTeacherReviews)
        .withConverter<Review>(
            fromFirestore: (snapshot, _) => Review.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .doc(FirebaseAuth.instance.currentUser!.uid);

    var teacherDocRef = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(review.teacherId);

    batch.set(reviewDocRef, review);
    batch.update(teacherDocRef, {'totRevs': FieldValue.increment(1)});

    return await batch.commit();
  }
}
