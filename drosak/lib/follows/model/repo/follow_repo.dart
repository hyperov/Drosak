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
    var batch = FirebaseFirestore.instance.batch();

    var teacherDocRef = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(FireStoreNames.collectionStudentFollows)
        .withConverter<Follow>(
            fromFirestore: (snapshot, _) => Follow.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .doc(follow.teacherId);

    return teacherDocRef.set(follow);
  }

  Future<void> incrementFollowsCountToStudentAndTeacher(
      String teacherId) async {
    var batch = FirebaseFirestore.instance.batch();

    var studentDocRef = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(FirebaseAuth.instance.currentUser!.uid);

    var teacherDocRef = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(teacherId);

    batch.update(studentDocRef, {'follows': FieldValue.increment(1)});
    batch.update(teacherDocRef, {'followers': FieldValue.increment(1)});
    await batch.commit();
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

    var studentDocRef = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(FirebaseAuth.instance.currentUser!.uid);

    var teacherDocRef = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(teacherId);
    // decerement follows count
    batch.update(studentDocRef, {'follows': FieldValue.increment(-1)});
    batch.update(teacherDocRef, {'followers': FieldValue.increment(-1)});
    await batch.commit();
  }
}
