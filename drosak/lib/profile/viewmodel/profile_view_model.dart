import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:get/get.dart';

class ProfileViewModel extends GetxController {
  RxString selectedGovernmentName = "اختر المحافظة".obs;
  RxString selectedAreaName = "اختر المنطقة".obs;

  RxString selectedType = LocalizationKeys.male.tr.obs;

  RxString selectedEducation = LocalizationKeys.education_secondary.tr.obs;

  RxString selectedClass = LocalizationKeys.class_level_one.tr.obs;

  void updateProfile() {}
}
