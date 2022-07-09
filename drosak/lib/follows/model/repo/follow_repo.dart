import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/follows/model/entity/Follow.dart';
import 'package:drosak/utils/firestore_names.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FollowRepo {
  Future<QuerySnapshot<Follow>> getStudentFollows(String studentId) {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(studentId)
        .collection(FireStoreNames.collectionStudentFollows)
        .withConverter<Follow>(
            fromFirestore: (snapshot, _) => Follow.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .get();
  }

  void unfollow(String teacherName) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(FireStoreNames.collectionStudentFollows)
        .where(FireStoreNames.followDocFieldTeacherName, isEqualTo: teacherName)
        .get();
    await querySnapshot.docs.first.reference.delete();
  }
}
