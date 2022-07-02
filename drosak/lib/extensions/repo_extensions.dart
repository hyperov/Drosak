import 'package:drosak/login/model/entity/first_time_login_student_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension ConvertUserToStudent on User {
  FirstTimeLoginStudentModel toFirstTimeLoginStudentModel() {
    return FirstTimeLoginStudentModel(
        id: uid,
        name: displayName ?? '',
        email: email ?? '',
        photoUrl: photoURL ?? '',
        phone: phoneNumber ?? '',
        createdAt: metadata.creationTime as DateTime,
        lastSignInTime: metadata.lastSignInTime as DateTime);
  }
}
