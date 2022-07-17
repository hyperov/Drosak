import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String studentName;
  String body;
  double rating;
  DateTime date;
  String teacherId;

  Review({
    required this.studentName,
    required this.body,
    required this.rating,
    required this.date,
    required this.teacherId,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        studentName: json["name"],
        body: json["review"],
        rating: (json["rating"])?.toDouble(),
        date: (json["date"] as Timestamp).toDate(),
        teacherId: json["teacher_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": studentName,
        "review": body,
        "rating": rating,
        "date": date,
        "teacher_id": teacherId,
      };
}
