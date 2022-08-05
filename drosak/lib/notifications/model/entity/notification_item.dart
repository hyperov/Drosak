import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationItem {
  String? title;
  String? message;
  DateTime? date;
  String? teacher;

  NotificationItem({
    this.title,
    this.message,
    this.date,
    this.teacher,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      title: json['title'],
      message: json['message'],
      date: (json['date'] as Timestamp).toDate(),
      teacher: json['teacher'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'date': Timestamp.fromDate(date!),
      'teacher': teacher,
    };
  }
}
