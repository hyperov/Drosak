import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/lectures/model/entity/lecture.dart';
import 'package:drosak/utils/firestore_names.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:get_storage/get_storage.dart';

class BookingsRepo {
  final _storage = GetStorage();

  Future<QuerySnapshot<Lecture>> getBookings() {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(_storage.read(StorageKeys.studentId))
        .collection(FireStoreNames.collectionStudentBookings)
        .withConverter<Lecture>(
          fromFirestore: (snapshot, _) => Lecture.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        )
        .get();
  }

  Future deleteBooking(String lectureId, String teacherId) async {
    return await FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(teacherId)
        .collection(FireStoreNames.collectionTeacherLectures)
        .doc(lectureId)
        .delete();
  }
}
