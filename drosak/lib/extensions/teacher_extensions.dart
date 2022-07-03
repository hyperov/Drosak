import 'package:drosak/teachers/model/teacher.dart';
import 'package:drosak/utils/firestore_names.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:get/get.dart';

extension CalculateTeacherEducationTypes on Teacher {
  String getEducationText() {
    var isSec =
        educationalLevel?.contains(FireStoreNames.educationLevelSecondaryValue);
    var isPrep =
        educationalLevel?.contains(FireStoreNames.educationLevelPrepValue);

    String res = '';
    if (isSec == true) {
      res = LocalizationKeys.secondary.tr + ' - ';
    }

    if (isPrep == true) {
      res += LocalizationKeys.prep.tr;
    }
    return res;
  }
}
