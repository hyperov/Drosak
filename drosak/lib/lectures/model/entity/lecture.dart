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
      required this.teacherName});

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
    );
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
      };
}
