import 'package:cloud_firestore/cloud_firestore.dart';

class Lecture {
  String? id;
  String centerName;
  String city; //cairo or giza
  String area; //dokki or saft or zamalek
  String address;
  String material;
  String classLevel;
  String day;
  String time;
  int price;
  String teacherName;
  String teacherImageUrl;
  DateTime? bookingDate;
  double? teacherRating;

  Lecture(
      {required this.centerName,
      required this.city,
      required this.area,
      required this.address,
      required this.material,
      required this.classLevel,
      required this.day,
      required this.time,
      required this.price,
      required this.teacherName,
      required this.teacherImageUrl,
      this.bookingDate,
      this.teacherRating});

  factory Lecture.fromJson(Map<String, dynamic> json) {
    return Lecture(
        centerName: json['center'],
        city: json['city'],
        area: json['area'],
        address: json['address'],
        material: json['material'],
        classLevel: json['level'],
        day: json['day'],
        time: json['time'],
        price: json['price'],
        teacherName: json['teacher'],
        teacherImageUrl: json['pic'],
        bookingDate: json['bookingDate'] == null
            ? null
            : (json['bookingDate'] as Timestamp).toDate(),
        teacherRating: json['rating']);
  }

  Map<String, dynamic> toJson() => {
        'center': centerName,
        'city': city,
        'area': area,
        'address': address,
        'material': material,
        'level': classLevel,
        'day': day,
        'time': time,
        'price': price,
        'teacher': teacherName,
        'pic': teacherImageUrl,
        'book_date': bookingDate,
        'rating': teacherRating,
      };
}
