import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/teachers/model/teacher.dart';
import 'package:drosak/utils/firestore_names.dart';

class TeachersRepo {
  Future<QuerySnapshot<Teacher>> getTeachers() async {
    return await FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .withConverter<Teacher>(
            fromFirestore: (snapshot, _) => Teacher.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .where(FireStoreNames.teacherDocFieldIsActive, isEqualTo: true)
        .get();
  }
}
