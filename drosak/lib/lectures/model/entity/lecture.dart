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
  bool isEnabled = true;

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
      required this.isEnabled});

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
        isEnabled: json['is_enabled']);
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
        'is_enabled': isEnabled
      };

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
    DateTime endDate = DateTime.now();
    int todayDay = endDate.weekday; // today day number

    var lecDay = getWeekDayNumber(); //1-7

    while (todayDay != lecDay) {
      endDate = endDate.add(const Duration(days: 1));
      todayDay = endDate.weekday;
    }
    return endDate;
  }
}
