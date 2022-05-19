import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/login/student.dart';
import 'package:firebase_auth/firebase_auth.dart';

extension ConvertUserToStudent on User {
  Student toStudent() {
    return Student(
        id: uid,
        name: displayName ?? '',
        email: email ?? '',
        photoUrl: photoURL ?? '',
        phone: phoneNumber ?? '',
        createdAt: metadata.creationTime as Timestamp,
        lastSignInTime: metadata.lastSignInTime as Timestamp,
        educationalLevel: "high school",
        classRoom: 1);
  }
}
