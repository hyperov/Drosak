import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/utils/firestore_names.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../entity/follow.dart';

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

  Future<DocumentReference<Follow>> addFollow(Follow follow) async {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(FireStoreNames.collectionStudentFollows)
        .withConverter<Follow>(
            fromFirestore: (snapshot, _) => Follow.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .add(follow);
  }

  Future<void> incrementFollowsCountToStudent() async {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'follows': FieldValue.increment(1)});
  }

  Future<void> deleteFollowDoc(String teacherName) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(FireStoreNames.collectionStudentFollows)
        .where(FireStoreNames.followDocFieldTeacherName, isEqualTo: teacherName)
        .get();

    var batch = FirebaseFirestore.instance.batch();

    batch.delete(querySnapshot.docs.first.reference);
    var docStudent = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(FirebaseAuth.instance.currentUser!.uid);
    // decerement follows count
    batch.update(docStudent, {'follows': FieldValue.increment(-1)});
    await batch.commit();
  }
}
