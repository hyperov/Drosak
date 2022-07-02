import 'package:cloud_firestore/cloud_firestore.dart';

class FirstTimeLoginStudentModel {
  String id;
  String name;
  String email;
  String photoUrl;
  String phone;
  DateTime createdAt;
  DateTime lastSignInTime;
  bool isLoggedIn = true;

  FirstTimeLoginStudentModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.photoUrl,
      required this.phone,
      required this.createdAt,
      required this.lastSignInTime});

  factory FirstTimeLoginStudentModel.fromJson(Map<String, dynamic> json) =>
      FirstTimeLoginStudentModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        photoUrl: json["photoUrl"],
        phone: json["phone"],
        createdAt: (json["createdAt"] as Timestamp).toDate(),
        lastSignInTime: (json["lastSignInTime"] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "phone": phone,
        "createdAt": createdAt,
        "lastSignInTime": lastSignInTime,
      };
}
