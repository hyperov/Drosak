import 'package:drosak/utils/firestore_names.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:get/get.dart';

class Follow {
  String teacherName;
  String teacherId;
  String teacherPhotoUrl;
  String material;
  String educationalLevel;
  String rating;
  bool isFollowing = true;

  Follow({
    required this.teacherName,
    required this.teacherId,
    required this.teacherPhotoUrl,
    required this.material,
    required this.educationalLevel,
    required this.rating,
  });

  String getEducationText() {
    return educationalLevel == FireStoreNames.educationLevelSecondaryValue
        ? LocalizationKeys.secondary.tr
        : LocalizationKeys.prep.tr;
  }

  factory Follow.fromJson(Map<String, dynamic> json) {
    return Follow(
      teacherName: json['name'],
      teacherId: json['id'],
      teacherPhotoUrl: json['pic'],
      material: json['material'],
      educationalLevel: json['eduLevel'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': teacherName,
      'id': teacherId,
      'pic': teacherPhotoUrl,
      'material': material,
      'eduLevel': educationalLevel,
      'rating': rating,
    };
  }
}
