import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/storage_keys.dart';
import '../model/entity/lecture.dart';
import '../model/repo/lectures_repo.dart';

class LecturesViewModel extends GetxController {
  final LecturesRepo _lecturesRepo = Get.put(LecturesRepo());

  final RxList<Lecture> lectures = <Lecture>[].obs;

  RxBool isLoading = false.obs;

  final _storage = GetStorage();

  Lecture? selectedLecture;
  int selectedIndex = -1;

  @override
  onReady() async {
    super.onReady();
    await getLectures();
  }

  getLectures() async {
    isLoading.value = true;

    String? teacherId = _storage.read<String>(StorageKeys.teacherId);

    var _lectures = await _lecturesRepo.getLectures(teacherId!);

    var lecturesDocs = _lectures.docs.map((doc) {
      var lecture = doc.data();
      lecture.id = doc.id; // set document id to lecture
      return lecture;
    });

    isLoading.value = false;
    lectures.clear();
    lectures.addAll(lecturesDocs);
  }

  Future<void> bookLecture(int index) async {
    selectedLecture = lectures[index];
    selectedIndex = index;
    selectedLecture?.bookingDate = DateTime.now();
    try {
      await _lecturesRepo.bookLecture(selectedLecture!);
      Get.snackbar(
        'Success',
        LocalizationKeys.lecture_booked.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
