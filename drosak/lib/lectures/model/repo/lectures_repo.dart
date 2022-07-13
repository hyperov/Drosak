import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/firestore_names.dart';
import '../entity/lecture.dart';

class LecturesRepo {
  Future<QuerySnapshot<Lecture>> getLectures(String teacherId) async {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(teacherId)
        .collection(FireStoreNames.collectionTeacherLectures)
        .withConverter<Lecture>(
          fromFirestore: (snapshot, _) => Lecture.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        )
        .get();
  }

  Future addOrEditLecture(Lecture lecture, String teacherId) async {
    if (lecture.id == null) {
      return await FirebaseFirestore.instance
          .collection(FireStoreNames.collectionTeachers)
          .doc(teacherId)
          .collection(FireStoreNames.collectionTeacherLectures)
          .add(lecture.toJson());
    } else {
      return await FirebaseFirestore.instance
          .collection(FireStoreNames.collectionTeachers)
          .doc(teacherId)
          .collection(FireStoreNames.collectionTeacherLectures)
          .doc(lecture.id)
          .update(lecture.toJson());
    }
  }

  Future deleteLecture(String lectureId, String teacherId) async {
    return await FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(teacherId)
        .collection(FireStoreNames.collectionTeacherLectures)
        .doc(lectureId)
        .delete();
  }
}
