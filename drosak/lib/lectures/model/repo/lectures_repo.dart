import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

import '../../../utils/firestore_names.dart';
import '../entity/lecture.dart';

class LecturesRepo {
  final _storage = GetStorage();

  Future<QuerySnapshot<Lecture>> getLectures(String teacherId) async {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(teacherId)
        .collection(FireStoreNames.collectionTeacherLectures)
        .withConverter<Lecture>(
          fromFirestore: (snapshot, _) => Lecture.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        )
        .where(FireStoreNames.lectureDocFieldIsEnabled, isEqualTo: true)
        .get();
  }
}
