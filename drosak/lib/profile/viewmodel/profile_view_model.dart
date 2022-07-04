import 'package:drosak/login/is_login_widget.dart';
import 'package:drosak/login/model/Repo/user_repo.dart';
import 'package:drosak/login/model/entity/student.dart';
import 'package:drosak/utils/firestore_names.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileViewModel extends GetxController {
  final UserRepo _userRepo = Get.find();
  final _storage = GetStorage();

  Rx<Student> student = Student().obs;

  RxString selectedGovernmentName = "اختر المحافظة".obs;
  RxString selectedAreaName = "اختر المنطقة".obs;

  RxString selectedType = LocalizationKeys.male.tr.obs;

  RxString selectedEducation = LocalizationKeys.education_secondary.tr.obs;

  RxString selectedClass = LocalizationKeys.class_level_one.tr.obs;

  //personal profile screen text controllers
  var nameController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;

  var classesObserver = <String>[].obs;
  var bookingsObserver = 0.obs;
  var followersObserver = 0.obs;
  var ratingObserver = 0.obs;
  var nameObserver = "".obs;
  var selectedProfileImageUrl = "".obs;
  RxString selectedGender = LocalizationKeys.male.tr.obs;

  //gallery and camera picker bottomsheet options
  final List<Icon> galleryPickerSheetLeadingIcons = const [
    Icon(Icons.photo_library),
    Icon(Icons.photo_camera),
  ];

  final List<String> galleryPickerSheetLeadingLeadingTexts = [
    LocalizationKeys.gallery.tr,
    LocalizationKeys.camera.tr,
  ];

  RxString selectedGalleryPickerSheetText = LocalizationKeys.gallery.tr.obs;

  @override
  Future<void> onInit() async {
    await getStudent();
    readStudentProfileDataFromStorage();
    super.onInit();
  }

  void updateProfile() {}

  Future<void> getStudent() async {
    var studentDoc = await _userRepo.getStudent();
    student.value = studentDoc.data()!;
    await _storage.write(StorageKeys.studentId, studentDoc.id);
    await _storage.write(StorageKeys.studentName, student.value.name);
    await _storage.write(StorageKeys.studentPhotoUrl, student.value.photoUrl);
    await _storage.write(StorageKeys.studentEmail, student.value.email);
    await _storage.write(StorageKeys.studentPhone, student.value.phone);
    await _storage.write(
        StorageKeys.studentBookingsNum, student.value.totalBookings);
    await _storage.write(StorageKeys.studentIsMale, student.value.male);
    await _storage.write(StorageKeys.studentArea, student.value.area);
    await _storage.write(StorageKeys.studentCity, student.value.city);
    await _storage.write(StorageKeys.studentClass, student.value.classRoom);
    await _storage.write(
        StorageKeys.studentEducationalLevel, student.value.educationalLevel);
  }

  readStudentProfileDataFromStorage() {
    var studentId = _storage.read(StorageKeys.studentId);
    var studentName = _storage.read(StorageKeys.studentName);

    if (studentName == null) {
      return;
    }

    var studentPhotoUrl = _storage.read(StorageKeys.studentPhotoUrl);
    var isStudentMale = _storage.read(StorageKeys.studentIsMale);
    var studentEmail = _storage.read(StorageKeys.studentEmail);
    var studentPhone = _storage.read(StorageKeys.studentPhone);
    var studentBookingsNum = _storage.read(StorageKeys.studentBookingsNum);
    var studentClass = _storage.read(StorageKeys.studentClass)!; //1,2,3
    var studentEducationalLevel =
        _storage.read(StorageKeys.studentEducationalLevel)!; // sec,prep

    if (studentEducationalLevel ==
        FireStoreNames.educationLevelSecondaryValue) {
      selectedEducation = LocalizationKeys.education_secondary.tr.obs;
    } else {
      selectedEducation = LocalizationKeys.education_prep.tr.obs;
    }

    nameObserver.value = studentName;
    nameController.value.text = studentName;
    phoneController.value.text = studentPhone;
    bookingsObserver.value = studentBookingsNum;
    selectedProfileImageUrl.value = studentPhotoUrl ?? "";

    selectedGender.value =
        isStudentMale ? LocalizationKeys.male.tr : LocalizationKeys.female.tr;
  }

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
