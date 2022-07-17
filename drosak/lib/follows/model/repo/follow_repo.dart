import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/utils/firestore_names.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../entity/follow.dart';

class FollowRepo {
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

    var followDocRef = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(FireStoreNames.collectionStudentFollows)
        .withConverter<Follow>(
            fromFirestore: (snapshot, _) => Follow.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .doc(follow.teacherId);

    var studentDocRef = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(FirebaseAuth.instance.currentUser!.uid);

    var teacherDocRef = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(follow.teacherId);

    batch.set(followDocRef, follow);
    batch.update(studentDocRef, {'follows': FieldValue.increment(1)});
    batch.update(teacherDocRef, {'followers': FieldValue.increment(1)});

    return await batch.commit();
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
