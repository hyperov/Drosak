import 'package:cloud_firestore/cloud_firestore.dart';

class Teacher {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? photoUrl; //pic
  String? material;
  bool? isMale;
  DateTime? lastSignInTime; //March 26, 2022 at 8:11:20 PM UTC+3
  DateTime? creationTime; //creation date of the account in the system
  bool? isLoggedIn;
  DateTime? contractDate; //begin of contract
  DateTime? expirationDate; //end of contract date till payment
  List<String>? educationalLevel; //”high_school” , ”middle_school”**
  List<String>? classes; //  الصف الاول الثانوى و الصف الاول الاعدادى وهكذا
  int? totalBookings;
  int? totalBookingsCanceled;
  String? code; //code of the teacher in the system (for the teacher to login)
  bool? active; //if the teacher is active or not (if the teacher is deleted)
  bool? isPaid; //if the teacher is paying or in free month
  int? fees;
  int? avgRating;
  int? totalReviews;
  int? followers;
  int? priceMin;
  int? priceMax;
  DateTime? lastScanTime; //can't exceed the expiration date
  int? scansPerMonth;

  Teacher(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.photoUrl,
      this.material,
      this.isMale,
      this.lastSignInTime,
      this.creationTime,
      this.isLoggedIn,
      this.contractDate,
      this.expirationDate,
      this.educationalLevel,
      this.classes,
      this.totalBookings,
      this.totalBookingsCanceled,
      this.code,
      this.active,
      this.isPaid,
      this.fees,
      this.avgRating,
      this.totalReviews,
      this.followers,
      this.priceMin,
      this.priceMax,
      this.lastScanTime,
      this.scansPerMonth}); //5 and decrease by 1 every scan

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        photoUrl: json['pic'],
        material: json['material'],
        isMale: json['is_male'],
        lastSignInTime: (json['lastSignInTime'] as Timestamp).toDate(),
        creationTime: (json['createdAt'] as Timestamp).toDate(),
        isLoggedIn: json['isLogin'],
        contractDate: (json['contract_date'] as Timestamp).toDate(),
        expirationDate: (json['exp_date'] as Timestamp).toDate(),
        educationalLevel: List<String>.from(json['eduLevel']),
        classes: List<String>.from(json['classes']),
        totalBookings: json['bookings'],
        totalBookingsCanceled: json['bookings_canceled'],
        code: json['code'],
        active: json['active'],
        isPaid: json['isPaid'],
        fees: json['fees'],
        avgRating: json['avgRating'],
        totalReviews: json['totRevs'],
        followers: json['followers'],
        priceMin: json['price_min'],
        priceMax: json['price_max'],
        lastScanTime: (json['last_scan_time'] as Timestamp).toDate(),
        scansPerMonth: json['scansPerMon'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'pic': photoUrl,
        'material': material,
        'is_male': isMale,
        'lastSignInTime': lastSignInTime,
        'createdAt': creationTime,
        'isLogin': isLoggedIn,
        'contract_date': contractDate,
        'exp_date': expirationDate,
        'eduLevel': educationalLevel,
        'classes': classes,
        'bookings': totalBookings,
        'bookings_canceled': totalBookingsCanceled,
        'code': code,
        'active': active,
        'isPaid': isPaid,
        'fees': fees,
        'avgRating': avgRating,
        'totRevs': totalReviews,
        'followers': followers,
        'price_min': priceMin,
        'price_max': priceMax,
        'last_scan_time': lastScanTime,
        'scansPerMon': scansPerMonth,
      };
}
