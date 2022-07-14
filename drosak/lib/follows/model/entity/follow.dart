import 'package:drosak/utils/firestore_names.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:get/get.dart';

class Follow {
  String teacherName;
  String teacherId;
  String teacherPhotoUrl;
  String material;
  List<String> educationalLevel;
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
    var isSec =
        educationalLevel.contains(FireStoreNames.educationLevelSecondaryValue);
    var isPrep =
        educationalLevel.contains(FireStoreNames.educationLevelPrepValue);

    String res = '';
    if (isSec == true) {
      res = LocalizationKeys.secondary.tr + ' - ';
    }

    if (isPrep == true) {
      res += LocalizationKeys.prep.tr;
    }
    return res;
  }

  factory Follow.fromJson(Map<String, dynamic> json) {
    return Follow(
      teacherName: json['name'],
      teacherId: json['id'],
      teacherPhotoUrl: json['pic'],
      material: json['material'],
      educationalLevel: List<String>.from(json['eduLevel']),
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
