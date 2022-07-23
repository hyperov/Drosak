import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/login/model/entity/student.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension ConvertUserToStudent on User {
  Student toStudent(String fcmToken) {
    return Student.def(
        id: uid,
        name: displayName ?? '',
        email: email ?? '',
        photoUrl: photoURL ?? '',
        phone: phoneNumber ?? '',
        createdAt: metadata.creationTime as DateTime,
        lastSignInTime: metadata.lastSignInTime as DateTime,
        fcmToken: fcmToken,
        fcmTimeStamp: Timestamp.now());
  }
}
