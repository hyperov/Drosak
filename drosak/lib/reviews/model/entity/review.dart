import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String body;
  double rating;
  DateTime date;
  String teacherId;
  String studentId = '';

  Review({
    required this.body,
    required this.rating,
    required this.date,
    required this.teacherId,
    required this.studentId,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        body: json["review"],
        rating: (json["rating"])?.toDouble(),
        date: (json["date"] as Timestamp).toDate(),
        teacherId: json["teacher_id"],
        studentId: json["student_id"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "review": body,
        "rating": rating,
        "date": date,
        "teacher_id": teacherId,
        "student_id": studentId,
      };
}
