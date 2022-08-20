import 'package:drosak/bindings/initial_bindings.dart';
import 'package:drosak/home/home_screen.dart';
import 'package:drosak/login/is_login_widget.dart';
import 'package:drosak/login/model/Repo/user_repo.dart';
import 'package:drosak/login/model/entity/student.dart';
import 'package:drosak/profile/model/student_profile_ui_model.dart';
import 'package:drosak/utils/firestore_names.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel extends GetxController {
  final UserRepo _userRepo = Get.find();
  final _storage = GetStorage();

  Rx<Student> student = Student().obs;

  // profile Ui texts
  RxString selectedGovernmentName = LocalizationKeys.choose_government.tr.obs;
  RxString selectedAreaName = LocalizationKeys.choose_area.tr.obs;
  RxString selectedEducationText =
      LocalizationKeys.education_secondary.tr.obs; // ثانوى
  RxString selectedClassText =
      LocalizationKeys.secondary_class_level_one.tr.obs; // الصف الاول الثانوى
  RxString selectedGender = LocalizationKeys.male.tr.obs;

  //personal profile screen text controllers
  var nameController = TextEditingController().obs;
  var phoneController = TextEditingController().obs;
  var emailController = TextEditingController().obs;

  var nameObserver = "الاسم".obs;

  var followsCountObserver = 0.obs;
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

  late StudentProfileUiModel studentProfile;
  final ImagePicker _imagePicker = ImagePicker();

  var studentClass;

  XFile? image;

  @override
  Future<void> onInit() async {
    super.onInit();
    EasyLoading.show(status: LocalizationKeys.loading.tr);
    await getStudent();
    readStudentProfileDataFromStorage();
    await EasyLoading.dismiss();
  }

  @override
  onReady() async {
    super.onReady();
    ever(selectedEducationText, (callback) {
      if (selectedEducationText.value ==
          LocalizationKeys.education_secondary.tr) {
        switch (studentClass) {
          case 1:
            selectedClassText.value =
                LocalizationKeys.secondary_class_level_one.tr;
            break;
          case 2:
            selectedClassText.value =
                LocalizationKeys.secondary_class_level_two.tr;
            break;
          case 3:
            selectedClassText.value =
                LocalizationKeys.secondary_class_level_three.tr;
            break;
        }
      } else {
        switch (studentClass) {
          case 1:
            selectedClassText.value = LocalizationKeys.prep_class_level_one.tr;
            break;
          case 2:
            selectedClassText.value = LocalizationKeys.prep_class_level_two.tr;
            break;
          case 3:
            selectedClassText.value =
                LocalizationKeys.prep_class_level_three.tr;
            break;
        }
      }
    });
  }

  void updateProfile() {
    //update ui locally
    nameObserver.value = nameController.value.text;

    //update student profile ui model
    studentProfile.studentName = nameController.value.text;
    studentProfile.studentPhone = phoneController.value.text;
    studentProfile.studentEmail = emailController.value.text;
    studentProfile.studentPhotoUrl = selectedProfileImageUrl.value;

    if (selectedEducationText.value ==
        LocalizationKeys.education_secondary.tr) {
      studentProfile.studentEducationalLevel =
          FireStoreNames.educationLevelSecondaryValue;
    } else {
      studentProfile.studentEducationalLevel =
          FireStoreNames.educationLevelPrepValue;
    }

    if (selectedClassText.value ==
            LocalizationKeys.secondary_class_level_one.tr ||
        selectedClassText.value == LocalizationKeys.prep_class_level_one.tr) {
      studentProfile.studentClass = 1;
    }
    if (selectedClassText.value ==
            LocalizationKeys.secondary_class_level_two.tr ||
        selectedClassText.value == LocalizationKeys.prep_class_level_two.tr) {
      studentProfile.studentClass = 2;
    }
    if (selectedClassText.value ==
            LocalizationKeys.secondary_class_level_three.tr ||
        selectedClassText.value == LocalizationKeys.prep_class_level_three.tr) {
      studentProfile.studentClass = 3;
    }

    studentProfile.studentGovernment = selectedGovernmentName.value;
    studentProfile.studentArea = selectedAreaName.value;

    studentProfile.isStudentMale =
        selectedGender.value == LocalizationKeys.male.tr;

    _userRepo.updateStudentProfile(studentProfile).then((value) async {
      EasyLoading.showSuccess(LocalizationKeys.profile_updated_successfully.tr);
      await getStudent();
      readStudentProfileDataFromStorage();
      await _storage.write(StorageKeys.isFirstTimeLogin, false);
      Get.offAll(() => HomeScreen(), binding: HomeBindings());
    }).catchError((error) {
      EasyLoading.showError(LocalizationKeys.profile_updated_error.tr);
      printError(info: error.toString());
    });
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
    await _storage.write(StorageKeys.followsCount, student.value.followsCount);
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
    studentClass = _storage.read(StorageKeys.studentClass)!; //1,2,3
    var studentEducationalLevel =
        _storage.read<String>(StorageKeys.studentEducationalLevel)!; // sec,prep
    var studentGovernment =
        _storage.read<String>(StorageKeys.studentGovernment)!; //cairo
    var studentArea = _storage.read<String>(StorageKeys.studentArea)!; //dokki

    //set ui controllers and observables
    nameController.value.text = studentName;
    phoneController.value.text = (studentPhone as String).isEmpty
        ? studentPhone
        : studentPhone.toString().replaceAll("+2", "");
    emailController.value.text = studentEmail;

    if (studentEducationalLevel.isEmpty) {
      selectedEducationText.value = LocalizationKeys.education_secondary.tr;
    } else if (studentEducationalLevel ==
        FireStoreNames.educationLevelSecondaryValue) {
      selectedEducationText.value = LocalizationKeys.education_secondary.tr;
      switch (studentClass) {
        case 1:
          selectedClassText.value =
              LocalizationKeys.secondary_class_level_one.tr;
          break;
        case 2:
          selectedClassText.value =
              LocalizationKeys.secondary_class_level_two.tr;
          break;
        case 3:
          selectedClassText.value =
              LocalizationKeys.secondary_class_level_three.tr;
          break;
      }
    } else {
      selectedEducationText.value = LocalizationKeys.education_prep.tr;
      switch (studentClass) {
        case 1:
          selectedClassText.value = LocalizationKeys.prep_class_level_one.tr;
          break;
        case 2:
          selectedClassText.value = LocalizationKeys.prep_class_level_two.tr;
          break;
        case 3:
          selectedClassText.value = LocalizationKeys.prep_class_level_three.tr;
          break;
      }
    }

    selectedGender.value =
        isStudentMale ? LocalizationKeys.male.tr : LocalizationKeys.female.tr;

    selectedGovernmentName.value = studentGovernment.isEmpty
        ? LocalizationKeys.choose_government.tr
        : studentGovernment;

    selectedAreaName.value =
        studentArea.isEmpty ? LocalizationKeys.choose_area.tr : studentArea;

    nameObserver.value = studentName;
    bookingsCountObserver.value = studentBookingsNum;
    followsCountObserver.value = followsCount;
    selectedProfileImageUrl.value = studentPhotoUrl;

    studentProfile = StudentProfileUiModel(
        studentId: studentId,
        studentName: studentName,
        studentPhotoUrl: studentPhotoUrl,
        studentEmail: studentEmail,
        studentPhone: studentPhone,
        studentGovernment: studentGovernment,
        studentArea: studentArea,
        isStudentMale: isStudentMale,
        studentClass: studentClass,
        studentEducationalLevel: studentEducationalLevel);
  }

  void logout() {
    _userRepo.signOutStudent().then((value) {
      FirebaseAuth.instance.signOut().then((value) async {
        EasyLoading.dismiss();
        var fcmToken = _storage.read(StorageKeys.fcmToken);
        await _storage.erase();
        await _storage.write(StorageKeys.fcmToken, fcmToken);

        Get.offAll(() => IsLoginWidget());
      });
    }).catchError((error) {
      printError(info: error.toString());
      printError(info: FirebaseAuth.instance.currentUser!.uid);
      EasyLoading.showError(LocalizationKeys.app_logout_error.tr);
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
      EasyLoading.showError(LocalizationKeys.choose_government_error.tr);
      return LocalizationKeys.choose_government.tr;
    }
  }

  String? _validateArea() {
    var area = selectedAreaName.value;
    if (area != LocalizationKeys.choose_area.tr) {
      return null;
    } else {
      EasyLoading.showError(LocalizationKeys.choose_area_error.tr);
      return LocalizationKeys.choose_area.tr;
    }
  }

  pickImage() async {
    var imageSource =
        selectedGalleryPickerSheetText.value == LocalizationKeys.camera.tr
            ? ImageSource.camera
            : ImageSource.gallery;
    image = await _imagePicker.pickImage(
      source: imageSource,
      imageQuality: 30,
    );
    if (image != null) {
      _userRepo.uploadStudentImage(image).then((imageUrl) async {
        selectedProfileImageUrl.value = imageUrl;
        await _userRepo.updateStudentProfileImage(imageUrl);
        await _storage.write(StorageKeys.studentPhotoUrl, imageUrl);
        EasyLoading.showSuccess(
            LocalizationKeys.profile_image_updated_successfully.tr);
        // await _homeViewModel.getTeacher();
        // readTeacherProfileDataFromStorage();
      }).catchError(
        (error) {
          EasyLoading.showError(
              LocalizationKeys.profile_image_updated_error.tr);
        },
      );
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nameController.value.dispose();
    phoneController.value.dispose();
    emailController.value.dispose();
  }
}
