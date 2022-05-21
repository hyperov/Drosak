import 'package:drosak/login/model/entity/student.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension ConvertUserToStudent on User {
  Student toStudent() {
    return Student(
        id: uid,
        name: displayName ?? '',
        email: email ?? '',
        photoUrl: photoURL ?? '',
        phone: phoneNumber ?? '',
        createdAt: metadata.creationTime as DateTime,
        lastSignInTime: metadata.lastSignInTime as DateTime,
        educationalLevel: "high school",
        classRoom: 1);
  }
}
