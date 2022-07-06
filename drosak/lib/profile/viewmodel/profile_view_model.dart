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

  // profile Ui texts
  RxString selectedGovernmentName = LocalizationKeys.choose_government.tr.obs;
  RxString selectedAreaName = LocalizationKeys.choose_area.tr.obs;
  RxString selectedEducation =
      LocalizationKeys.education_secondary.tr.obs; // ثانوى
  RxString selectedClass =
      LocalizationKeys.secondary_class_level_one.tr.obs; // الصف الاول الثانوى
  RxString selectedGender = LocalizationKeys.male.tr.obs;

  //personal profile screen text controllers
  var nameController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var emailController = TextEditingController().obs;

  var nameObserver = "الاسم".obs;

  var followsCountObserver = 0.obs;
  var favCountObserver = 0.obs;
  var bookingsCountObserver = 0.obs;
  var selectedProfileImageUrl = "".obs;

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

  final errMessagePhoneTextField = RxnString();
  final errMessageEmailTextField = RxnString();
  final errMessageNameTextField = RxnString();

  @override
  Future<void> onInit() async {
    await getStudent();
    readStudentProfileDataFromStorage();
    super.onInit();
  }

  void updateProfile() {
    nameObserver.value = nameController.value.text;

    // teacherProfile.teacherName = nameController.value.text;
    // teacherProfile.teacherPhone = phoneController.value.text;
    // teacherProfile.isTeacherMale =
    //     selectedGender.value == LocalizationKeys.male.tr;
    // teacherProfile.teacherMaterial = selectedMaterialIndex.value != null
    //     ? materialsUI[selectedMaterialIndex.value!].value
    //     : "";
    // teacherProfile.teacherPhotoUrl = selectedProfileImageUrl.value;
    // teacherProfile.teacherClasses = classes;

    // _userRepo.updateStudentProfile(teacherProfile).then((value) async {
    //   Get.snackbar(
    //     'Success',
    //     LocalizationKeys.profile_updated_successfully.tr,
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.green,
    //     duration: const Duration(seconds: 2),
    //   );
    //   await getStudent();
    //   readStudentProfileDataFromStorage();
    // }).catchError((error) {
    //   Get.snackbar(
    //     'Error',
    //     LocalizationKeys.profile_updated_error.tr,
    //     snackPosition: SnackPosition.BOTTOM,
    //     backgroundColor: Colors.red,
    //     duration: const Duration(seconds: 2),
    //   );
    // });
  }

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
    await _storage.write(
        StorageKeys.studentGovernment, student.value.government);
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
    var followsCount = _storage.read(StorageKeys.followsCount);
    var favCount = _storage.read(StorageKeys.favCount);
    var studentClass = _storage.read(StorageKeys.studentClass)!; //1,2,3
    var studentEducationalLevel =
        _storage.read(StorageKeys.studentEducationalLevel)!; // sec,prep
    var studentGovernment =
        _storage.read(StorageKeys.studentGovernment)!; //cairo
    var studentArea = _storage.read(StorageKeys.studentArea)!; //dokki

    nameController.value.text = studentName;
    phoneController.value.text = studentPhone.isBlank
        ? ""
        : studentPhone.toString().replaceAll("+2", "");
    emailController.value.text = studentEmail;

    if (studentEducationalLevel ==
        FireStoreNames.educationLevelSecondaryValue) {
      selectedEducation = LocalizationKeys.education_secondary.tr.obs;
      switch (studentClass) {
        case 1:
          selectedClass = LocalizationKeys.secondary_class_level_one.tr.obs;
          break;
        case 2:
          selectedClass = LocalizationKeys.secondary_class_level_two.tr.obs;
          break;
        case 3:
          selectedClass = LocalizationKeys.secondary_class_level_three.tr.obs;
          break;
      }
    } else {
      selectedEducation = LocalizationKeys.education_prep.tr.obs;
      switch (studentClass) {
        case 1:
          selectedClass = LocalizationKeys.prep_class_level_one.tr.obs;
          break;
        case 2:
          selectedClass = LocalizationKeys.prep_class_level_two.tr.obs;
          break;
        case 3:
          selectedClass = LocalizationKeys.prep_class_level_three.tr.obs;
          break;
      }
    }

    selectedGender.value =
        isStudentMale ? LocalizationKeys.male.tr : LocalizationKeys.female.tr;

    selectedGovernmentName.value = studentGovernment.isBlank
        ? LocalizationKeys.choose_government.tr
        : studentGovernment;

    selectedAreaName.value =
        studentArea.isBlank ? LocalizationKeys.choose_area.tr : studentArea;

    nameObserver.value = studentName;
    bookingsCountObserver.value = studentBookingsNum;
    followsCountObserver.value = followsCount;
    selectedProfileImageUrl.value = studentPhotoUrl ?? "";
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

  String? validateProfile() {
    if (_validateName() == null &&
        _validatePhone() == null &&
        _validateEmail() == null &&
        _validateGovernment() == null &&
        _validateArea() == null) {
      return null;
    }
    return LocalizationKeys.profile_updated_error.tr;
  }

  String? _validatePhone() {
    var phone = phoneController.value.text;
    if (phone.isEmpty) {
      errMessagePhoneTextField.value =
          LocalizationKeys.phone_number_error_empty.tr;
      return LocalizationKeys.phone_number_error_empty.tr;
    }
    if (phone.length != 11) {
      errMessagePhoneTextField.value =
          LocalizationKeys.phone_number_error_length.tr;
      return LocalizationKeys.phone_number_error_length.tr;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      errMessagePhoneTextField.value =
          LocalizationKeys.phone_number_error_format.tr;
      return LocalizationKeys.phone_number_error_format.tr;
    }
    errMessagePhoneTextField.value = null;
    return null;
  }

  String? _validateEmail() {
    var email = emailController.value.text;
    if (email.isEmpty) {
      errMessageEmailTextField.value = LocalizationKeys.email_error_empty.tr;
      return LocalizationKeys.email_error_empty.tr;
    }
    if (!RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$')
        .hasMatch(email)) {
      errMessageEmailTextField.value = LocalizationKeys.email_error_format.tr;
      return LocalizationKeys.email_error_format.tr;
    }
    errMessageEmailTextField.value = null;
    return null;
  }

  String? _validateName() {
    var name = nameController.value.text;
    if (name.isEmpty) {
      errMessageNameTextField.value = LocalizationKeys.name_error_empty.tr;
      return LocalizationKeys.name_error_empty.tr;
    }
    errMessageNameTextField.value = null;
    return null;
  }

  String? _validateGovernment() {
    var government = selectedGovernmentName.value;
    if (government != LocalizationKeys.choose_government.tr) {
      return null;
    } else {
      Get.snackbar(
        LocalizationKeys.app_error_update_data.tr,
        LocalizationKeys.choose_government_error.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      return LocalizationKeys.choose_government.tr;
    }
  }

  String? _validateArea() {
    var area = selectedAreaName.value;
    if (area != LocalizationKeys.choose_area.tr) {
      return null;
    } else {
      Get.snackbar(
        LocalizationKeys.app_error_update_data.tr,
        LocalizationKeys.choose_area_error.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
      return LocalizationKeys.choose_area.tr;
    }
  }
}
