import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationItem {
  String? title;
  String? message;
  DateTime? date;

  NotificationItem({
    this.title,
    this.message,
    this.date,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      title: json['title'],
      message: json['message'],
      date: (json['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'date': Timestamp.fromDate(date!),
    };
  }
}
