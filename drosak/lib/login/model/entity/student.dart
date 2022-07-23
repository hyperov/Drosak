import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? photoUrl;

  String? government; //cairo or giza
  String? area; //dokki or saft or zamalek

  DateTime? lastSignInTime; //March 26, 2022 at 8:11:20 PM UTC+3
  DateTime? createdAt; //March 26, 2022 at 8:11:20 PM UTC+3

  bool? male;
  bool? isLoggedIn;

  String? educationalLevel; //”high_school” or ”middle_school”**

  int?
      classRoom; // لو ثانوى يبقى الصف الاول الثانوى ولو اعدادى يبقى الصف الاول الاعدادى وهكذا

  int? totalBookings;
  int? totalBookingsCanceled;

  int? followsCount;
  String fcmToken = "";
  Timestamp fcmTimeStamp = Timestamp.now();

  Student();

  //<editor-fold desc="Data Methods">
  Student.def(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      this.photoUrl = "",
      this.government = "",
      this.area = "",
      required this.lastSignInTime,
      required this.createdAt,
      this.male = true,
      this.isLoggedIn = true,
      this.educationalLevel = "",
      this.classRoom = 1,
      this.totalBookings = 0,
      this.totalBookingsCanceled = 0,
      this.followsCount = 0,
      required this.fcmToken,
      required this.fcmTimeStamp});

  @override
  String toString() {
    return 'Student{' +
        ' id: $id,' +
        ' name: $name,' +
        ' email: $email,' +
        ' phone: $phone,' +
        ' photoUrl: $photoUrl,' +
        ' city: $government,' +
        ' area: $area,' +
        ' lastSignInTime: $lastSignInTime,' +
        ' createdAt: $createdAt,' +
        ' male: $male,' +
        ' isLoggedIn: $isLoggedIn,' +
        ' educationalLevel: $educationalLevel,' +
        ' classRoom: $classRoom,' +
        ' totalBookings: $totalBookings,' +
        ' totalBookingsCanceled: $totalBookingsCanceled,' +
        '}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'gov': government,
      'area': area,
      'lastSignInTime': lastSignInTime,
      'createdAt': createdAt,
      'male': male,
      'isLogin': isLoggedIn,
      'eduLevel': educationalLevel,
      'class': classRoom,
      'bookings': totalBookings,
      'bookings_canceled': totalBookingsCanceled,
      'follows': followsCount,
      'fcm_token': fcmToken,
      'fcm_date': fcmTimeStamp,
    };
  }

  factory Student.fromJson(Map<String, dynamic> map) {
    return Student.def(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String?,
      photoUrl: map['photoUrl'] as String?,
      government: map['gov'] as String,
      area: map['area'] as String,
      lastSignInTime: (map['lastSignInTime'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      male: map['male'] as bool,
      isLoggedIn: map['isLogin'] as bool,
      educationalLevel: map['eduLevel'] as String,
      classRoom: map['class'] as int,
      totalBookings: map['bookings'] as int,
      totalBookingsCanceled: map['bookings_canceled'] as int,
      followsCount: map['follows'] as int,
      fcmToken: map['fcm_token'] as String,
      fcmTimeStamp: map['fcm_date'] as Timestamp,
    );
  }
}
