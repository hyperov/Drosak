import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String studentName;
  String body;
  int rating;
  DateTime date;

  Review({
    required this.studentName,
    required this.body,
    required this.rating,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        studentName: json["name"],
        body: json["review"],
        rating: json["rating"],
        date: (json["date"] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "name": studentName,
        "review": body,
        "rating": rating,
        "date": date,
      };
}
