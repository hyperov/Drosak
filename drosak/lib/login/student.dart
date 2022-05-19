import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String id;
  String name;
  String email;
  String? phone;
  String photoUrl;

  String city; //cairo or giza
  String area; //dokki or saft or zamalek

  Timestamp lastSignInTime; //March 26, 2022 at 8:11:20 PM UTC+3
  Timestamp createdAt; //March 26, 2022 at 8:11:20 PM UTC+3

  bool male;
  bool isLoggedIn;

  String educationalLevel; //”high_school” or ”middle_school”**

  int classRoom; // لو ثانوى يبقى الصف الاول الثانوى ولو اعدادى يبقى الصف الاول الاعدادى وهكذا

  int totalBookings;
  int totalBookingsCanceled;

  bool hasFavorite;

//<editor-fold desc="Data Methods">

  Student({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.photoUrl = "",
    this.city = "",
    this.area = "",
    required this.lastSignInTime,
    required this.createdAt,
    this.male = true,
    this.isLoggedIn = true,
    required this.educationalLevel,
    required this.classRoom,
    this.totalBookings = 0,
    this.totalBookingsCanceled = 0,
    this.hasFavorite = false,
  });

//if @override
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          phone == other.phone &&
          photoUrl == other.photoUrl &&
          city == other.city &&
          area == other.area &&
          lastSignInTime == other.lastSignInTime &&
          createdAt == other.createdAt &&
          male == other.male &&
          isLoggedIn == other.isLoggedIn &&
          educationalLevel == other.educationalLevel &&
          classRoom == other.classRoom &&
          totalBookings == other.totalBookings &&
          totalBookingsCanceled == other.totalBookingsCanceled &&
          hasFavorite == other.hasFavorite);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      photoUrl.hashCode ^
      city.hashCode ^
      area.hashCode ^
      lastSignInTime.hashCode ^
      createdAt.hashCode ^
      male.hashCode ^
      isLoggedIn.hashCode ^
      educationalLevel.hashCode ^
      classRoom.hashCode ^
      totalBookings.hashCode ^
      totalBookingsCanceled.hashCode ^
      hasFavorite.hashCode;

  @override
  String toString() {
    return 'Student{' +
        ' id: $id,' +
        ' name: $name,' +
        ' email: $email,' +
        ' phone: $phone,' +
        ' photoUrl: $photoUrl,' +
        ' city: $city,' +
        ' area: $area,' +
        ' lastSignInTime: $lastSignInTime,' +
        ' createdAt: $createdAt,' +
        ' male: $male,' +
        ' isLoggedIn: $isLoggedIn,' +
        ' educationalLevel: $educationalLevel,' +
        ' classRoom: $classRoom,' +
        ' totalBookings: $totalBookings,' +
        ' totalBookingsCanceled: $totalBookingsCanceled,' +
        ' hasFavorite: $hasFavorite,' +
        '}';
  }

  Student copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? photoUrl,
    String? city,
    String? area,
    Timestamp? lastSignInTime,
    Timestamp? createdAt,
    bool? male,
    bool? isLoggedIn,
    String? educationalLevel,
    int? classRoom,
    int? totalBookings,
    int? totalBookingsCanceled,
    bool? hasFavorite,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      city: city ?? this.city,
      area: area ?? this.area,
      lastSignInTime: lastSignInTime ?? this.lastSignInTime,
      createdAt: createdAt ?? this.createdAt,
      male: male ?? this.male,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      educationalLevel: educationalLevel ?? this.educationalLevel,
      classRoom: classRoom ?? this.classRoom,
      totalBookings: totalBookings ?? this.totalBookings,
      totalBookingsCanceled:
          totalBookingsCanceled ?? this.totalBookingsCanceled,
      hasFavorite: hasFavorite ?? this.hasFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'city': city,
      'area': area,
      'lastSignInTime': lastSignInTime,
      'createdAt': createdAt,
      'male': male,
      'isLoggedIn': isLoggedIn,
      'educationalLevel': educationalLevel,
      'classRoom': classRoom,
      'totalBookings': totalBookings,
      'totalBookingsCanceled': totalBookingsCanceled,
      'hasFavorite': hasFavorite,
    };
  }

  factory Student.fromJson(Map<String, dynamic> map) {
    return Student(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String?,
      photoUrl: map['photoUrL'] as String,
      lastSignInTime: map['lastSignInTime'] as Timestamp,
      createdAt: map['createdAt'] as Timestamp,
      male: map['male'] as bool,
      isLoggedIn: map['isLoggedIn'] as bool,
      educationalLevel: map['educationalLevel'] as String,
      classRoom: map['classRoom'] as int,
      totalBookings: map['totalBookings'] as int,
      totalBookingsCanceled: map['totalBookingsCanceled'] as int,
      hasFavorite: map['hasFavorite'] as bool,
    );
  }
}
