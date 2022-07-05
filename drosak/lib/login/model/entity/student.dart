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

  bool? hasFavorite;
  int? followsCount;
  int? favCount;

  Student();

  //<editor-fold desc="Data Methods">
  Student.def({
    required this.id,
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
    this.classRoom = 0,
    this.totalBookings = 0,
    this.totalBookingsCanceled = 0,
    this.hasFavorite = false,
    this.followsCount = 0,
    this.favCount = 0,
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
          government == other.government &&
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
      government.hashCode ^
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
        ' hasFavorite: $hasFavorite,' +
        '}';
  }

  Student copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? photoUrl,
    String? government,
    String? area,
    DateTime? lastSignInTime,
    DateTime? createdAt,
    bool? male,
    bool? isLoggedIn,
    String? educationalLevel,
    int? classRoom,
    int? totalBookings,
    int? totalBookingsCanceled,
    bool? hasFavorite,
    followsCount,
    favCount,
  }) {
    return Student.def(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      government: government ?? this.government,
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
      followsCount: followsCount ?? this.followsCount,
      favCount: favCount ?? this.favCount,
    );
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
      'hasFav': hasFavorite,
      'follows': followsCount,
      'favs': favCount,
    };
  }

  factory Student.fromJson(Map<String, dynamic> map) {
    return Student.def(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String?,
      photoUrl: map['photoUrL'],
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
      hasFavorite: map['hasFav'] as bool,
      followsCount: map['follows'] as int,
      favCount: map['favs'] as int,
    );
  }
}
