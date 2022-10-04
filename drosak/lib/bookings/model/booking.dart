import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
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
  DateTime bookingDate;
  DateTime? lecDate;
  double teacherRating;
  bool isCanceled;
  String lectureId;
  String teacherId;
  String teacherPhone;

  Booking(
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
      required this.bookingDate,
      this.lecDate,
      required this.teacherRating,
      required this.isCanceled,
      required this.lectureId,
      required this.teacherId,
      required this.teacherPhone});

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
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
        bookingDate: (json['book_date'] as Timestamp).toDate(),
        lecDate: (json['lec_date'] as Timestamp).toDate(),
        teacherRating: double.parse(json['rating'].toString()),
        isCanceled: json['is_canceled'],
        lectureId: json['lec_id'],
        teacherId: json['teacher_id'],
        teacherPhone: json['teacher_phone'] ?? "");
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
        'lec_date': lecDate,
        'rating': teacherRating,
        'is_canceled': isCanceled,
        'lec_id': lectureId,
        'teacher_id': teacherId,
        'teacher_phone': teacherPhone
      };

  getWeekDayText() {
    switch (day) {
      case 'الاثنين':
        return 'monday';
      case 'الثلاثاء':
        return 'tuesday';
      case 'الاربعاء':
        return 'wednesday';
      case 'الخميس':
        return 'thursday';
      case 'الجمعة':
        return 'friday';
      case 'السبت':
        return 'saturday';
      case 'الأحد':
        return 'sunday';
    }
  }

  int getWeekDayNumber() {
    switch (day) {
      case 'الاثنين':
        return 1;
      case 'الثلاثاء':
        return 2;
      case 'الاربعاء':
        return 3;
      case 'الخميس':
        return 4;
      case 'الجمعة':
        return 5;
      case 'السبت':
        return 6;
      case 'الأحد':
        return 7;
    }
    return 1;
  }

  DateTime getLectureDate() {
    DateTime endDate =
        DateTime(bookingDate.year, bookingDate.month, bookingDate.day);

    int todayDay = endDate.weekday; // today day number

    var lecDay = getWeekDayNumber(); //1-7

    while (todayDay != lecDay) {
      endDate = endDate.add(const Duration(days: 1));
      todayDay = endDate.weekday;
    }
    return endDate;
  }

  //can't cancel booking if window is less than 24 hours
  bool isBookingCancellable() {
    var lectureDate = getLectureDate();
    var diff = lectureDate.difference(bookingDate);

    return diff.inHours > 24;
  }
}
