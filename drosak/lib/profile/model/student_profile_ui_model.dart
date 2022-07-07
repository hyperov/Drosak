class StudentProfileUiModel {
  String studentId;
  String studentName;
  String studentPhotoUrl;
  String studentEmail;
  String studentPhone;
  String studentGovernment;
  String studentArea;
  bool isStudentMale;
  int studentClass;
  String studentEducationalLevel;

  StudentProfileUiModel(
      {required this.studentId,
      required this.studentName,
      required this.studentPhotoUrl,
      required this.studentEmail,
      required this.studentPhone,
      required this.studentGovernment,
      required this.studentArea,
      required this.isStudentMale,
      required this.studentClass,
      required this.studentEducationalLevel});

  factory StudentProfileUiModel.fromJson(Map<String, dynamic> json) {
    return StudentProfileUiModel(
      studentId: json['id'],
      studentName: json['name'],
      studentPhotoUrl: json['photoUrl'],
      studentEmail: json['email'],
      studentPhone: json['phone'],
      studentGovernment: json['gov'],
      studentArea: json['area'],
      isStudentMale: json['male'],
      studentClass: json['class'],
      studentEducationalLevel: json['eduLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': studentId,
      'name': studentName,
      'photoUrl': studentPhotoUrl,
      'email': studentEmail,
      'phone': studentPhone,
      'gov': studentGovernment,
      'area': studentArea,
      'male': isStudentMale,
      'class': studentClass,
      'eduLevel': studentEducationalLevel,
    };
  }
}
