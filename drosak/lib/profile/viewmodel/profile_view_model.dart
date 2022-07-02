import 'package:drosak/login/is_login_widget.dart';
import 'package:drosak/login/model/Repo/user_repo.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileViewModel extends GetxController {
  final UserRepo _userRepo = Get.find();
  final _storage = GetStorage();

  RxString selectedGovernmentName = "اختر المحافظة".obs;
  RxString selectedAreaName = "اختر المنطقة".obs;

  RxString selectedType = LocalizationKeys.male.tr.obs;

  RxString selectedEducation = LocalizationKeys.education_secondary.tr.obs;

  RxString selectedClass = LocalizationKeys.class_level_one.tr.obs;

  void updateProfile() {}

  void logout() {
    FirebaseAuth.instance.signOut().then((value) {
      _userRepo.signOutStudent().then((value) async {
        await _storage.erase();
        Get.offAll(() => IsLoginWidget());
      });
    }).catchError((error) {
      printError(info: error.toString());
      Get.snackbar(
        'Error',
        LocalizationKeys.app_logout_error.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      );
    });
  }
}
