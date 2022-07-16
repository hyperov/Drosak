import 'package:drosak/bookings/model/booking.dart';
import 'package:drosak/bookings/model/bookings_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/storage_keys.dart';
import '../model/entity/lecture.dart';
import '../model/repo/lectures_repo.dart';

class LecturesViewModel extends GetxController {
  final LecturesRepo _lecturesRepo = Get.put(LecturesRepo());
  final BookingsRepo _bookingsRepo = Get.put(BookingsRepo());

  final RxList<Lecture> lectures = <Lecture>[].obs;

  RxBool isLoading = false.obs;

  final _storage = GetStorage();

  late Lecture selectedLecture;
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

    Booking _booking = Booking(
      centerName: selectedLecture.centerName,
      city: selectedLecture.city,
      area: selectedLecture.area,
      address: selectedLecture.address,
      material: selectedLecture.material,
      classLevel: selectedLecture.classLevel,
      day: selectedLecture.day,
      time: selectedLecture.time,
      price: selectedLecture.price,
      teacherName: selectedLecture.teacherName,
      teacherImageUrl: selectedLecture.teacherImageUrl,
      bookingDate: DateTime.now(),
      teacherRating: _storage.read<double>(StorageKeys.teacherRating)!,
      isCanceled: false,
      lectureId: selectedLecture.id!,
    );

    _booking.lecDate = _booking.getLectureDate();

    try {
      await _bookingsRepo.addBooking(_booking);
      await _bookingsRepo.incrementBookingCountToStudent();
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
