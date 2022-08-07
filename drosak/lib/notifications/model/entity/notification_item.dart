import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationItem {
  String? message;
  DateTime? date;
  String? teacher;

  NotificationItem({
    this.message,
    this.date,
    this.teacher,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      message: json['message'],
      date: (json['date'] as Timestamp).toDate(),
      teacher: json['teacher'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'date': Timestamp.fromDate(date!),
      'teacher': teacher,
    };
  }
}
