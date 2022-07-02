import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/extensions/repo_extensions.dart';
import 'package:drosak/login/model/entity/first_time_login_student_model.dart';
import 'package:drosak/utils/firestore_names.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class UserRepo {
  final _storage = GetStorage();

  Future<void> insertUserFirstTime(User user) {
    var firstTimeLoginStudentModel = user.toFirstTimeLoginStudentModel();

    var documentReference = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(user.uid)
        .withConverter<FirstTimeLoginStudentModel>(
          fromFirestore: (snapshot, _) =>
              FirstTimeLoginStudentModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );

    return documentReference.set(
        firstTimeLoginStudentModel, SetOptions(merge: true));
  }

  Future<void> signOutStudent() async {
    await FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(_storage.read(StorageKeys.studentId))
        .update({'isLogin': false});
  }

  Future<void> updateUserLoginStatus(User user) async {
    await FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(user.uid)
        .update({'isLogin': true, 'lastSignInTime': DateTime.now()});
  }
}
