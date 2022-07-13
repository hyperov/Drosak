import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? id;
  String title;
  String body;
  String teacherName;
  DateTime date;

  Post({
    required this.title,
    required this.body,
    required this.teacherName,
    required this.date,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        title: json["title"],
        body: json["body"],
        teacherName: json["teacher"],
        date: (json["date"] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "teacher": teacherName,
        "date": date,
      };
}
