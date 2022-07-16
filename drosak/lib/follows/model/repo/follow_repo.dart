import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/utils/firestore_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

import '../entity/follow.dart';

class FollowRepo {
  final _storage = GetStorage();

  Stream<QuerySnapshot<Follow>> getStudentFollows(String studentId) {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(studentId)
        .collection(FireStoreNames.collectionStudentFollows)
        .withConverter<Follow>(
            fromFirestore: (snapshot, _) => Follow.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .snapshots();
  }

  Future<void> addFollow(Follow follow) async {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(FireStoreNames.collectionStudentFollows)
        .withConverter<Follow>(
            fromFirestore: (snapshot, _) => Follow.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .doc(follow.teacherId)
        .set(follow);
  }

  Future<void> incrementFollowsCountToStudent() async {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'follows': FieldValue.increment(1)});
  }

  Future<void> deleteFollowDoc(String teacherId) async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(FireStoreNames.collectionStudentFollows)
        .where(FireStoreNames.followDocFieldTeacherId, isEqualTo: teacherId)
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
