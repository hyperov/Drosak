import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/utils/firestore_names.dart';

import '../entity/notification_item.dart';

class NotificationRepo {
  Stream<QuerySnapshot<NotificationItem>> getStudentNotifications(
      String studentId) {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(studentId)
        .collection(FireStoreNames.collectionStudentNotifications)
        .withConverter<NotificationItem>(
            fromFirestore: (snapshot, _) =>
                NotificationItem.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .snapshots();
  }

// Future<void> deleteFollowDoc(String teacherId) async {
//   var querySnapshot = await FirebaseFirestore.instance
//       .collection(FireStoreNames.collectionStudents)
//       .doc(FirebaseAuth.instance.currentUser!.uid)
//       .collection(FireStoreNames.collectionStudentFollows)
//       .where(FireStoreNames.followDocFieldTeacherId, isEqualTo: teacherId)
//       .get();
//
//   var batch = FirebaseFirestore.instance.batch();
//
//   batch.delete(querySnapshot.docs.first.reference);
//
//   var studentDocRef = FirebaseFirestore.instance
//       .collection(FireStoreNames.collectionStudents)
//       .doc(FirebaseAuth.instance.currentUser!.uid);
//
//   var teacherDocRef = FirebaseFirestore.instance
//       .collection(FireStoreNames.collectionTeachers)
//       .doc(teacherId);
//
//   var appStatsDocRef = FirebaseFirestore.instance
//       .collection(FireStoreNames.collectionAppStatistics)
//       .doc(FireStoreNames.documentAppStatistics);
//
//   // decerement follows count
//   batch.update(studentDocRef, {'follows': FieldValue.increment(-1)});
//   batch.update(teacherDocRef, {'followers': FieldValue.increment(-1)});
//   batch.update(appStatsDocRef, {'follows': FieldValue.increment(-1)});
//   await batch.commit();
// }
}
