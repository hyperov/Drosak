import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/extensions/repo_extensions.dart';
import 'package:drosak/login/model/entity/student.dart';
import 'package:drosak/profile/model/student_profile_ui_model.dart';
import 'package:drosak/utils/firestore_names.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserRepo {
  final _storage = GetStorage();

  Future<void> insertUserFirstTime(User user) {
    var student = user.toStudent();

    var documentReference = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(user.uid)
        .withConverter<Student>(
          fromFirestore: (snapshot, _) => Student.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );

    return documentReference.set(student, SetOptions(merge: true));
  }

  Future<void> signOutStudent() async {
    await FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(_storage.read(StorageKeys.studentId))
        .update({FireStoreNames.studentDocFieldIsLogin: false});
  }

  Future<void> updateUserLoginStatus(User user) async {
    await FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(user.uid)
        .update({
      FireStoreNames.studentDocFieldIsLogin: true,
      FireStoreNames.studentDocFieldLastSignInTime: DateTime.now()
    });
  }

  Future<DocumentSnapshot<Student>> getStudent() => FirebaseFirestore.instance
      .collection(FireStoreNames.collectionStudents)
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .withConverter<Student>(
        fromFirestore: (snapshot, _) => Student.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      )
      .get();

  Future<void> updateStudentProfile(StudentProfileUiModel studentProfile) {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(studentProfile.toJson(), SetOptions(merge: true));
  }

  Future<String> uploadStudentImage(XFile? image) async {
    var file = File(image!.path);

    final storageRef = FirebaseStorage.instance.ref();
    final imagesTeacherProfileRef =
        storageRef.child("student_profiles/profile.jpg");
    var taskSnapshot = await imagesTeacherProfileRef.putFile(file);
    return taskSnapshot.ref.getDownloadURL();
  }
}
