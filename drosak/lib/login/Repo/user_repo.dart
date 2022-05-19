import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/extensions/repo_extensions.dart';
import 'package:drosak/login/student.dart';
import 'package:drosak/utils/firestore_names.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepo {
  Future<void> insertUser(User user) async {
    var student = user.toStudent();

    var documentReference = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(student.id)
        .withConverter<Student>(
          fromFirestore: (snapshot, _) => Student.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );

    return documentReference.set(student, SetOptions(merge: true));
  }
}
