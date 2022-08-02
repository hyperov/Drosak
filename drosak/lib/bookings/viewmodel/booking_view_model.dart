import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/bookings/model/booking.dart';
import 'package:drosak/bookings/model/bookings_repo.dart';
import 'package:drosak/lectures/model/entity/lecture.dart';
import 'package:drosak/teachers/model/teacher.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BookingsViewModel extends GetxController {
  final BookingsRepo _bookingRepo = Get.put(BookingsRepo());

  final _storage = GetStorage();
  final RxList<Booking> bookings = <Booking>[].obs;

  RxBool isLoading = false.obs;

  int selectedIndex = -1;

  late StreamSubscription<QuerySnapshot<Booking>> bookingsListener;

  late Teacher selectedTeacher;

  @override
  onReady() async {
    super.onReady();
    await getBookings();
  }

  getBookings() async {
    isLoading.value = true;

    var _bookingsStream = _bookingRepo.getBookings();

    bookingsListener = _bookingsStream.listen((_bookings) {
      var bookingsDocs = _bookings.docs.map((doc) {
        var booking = doc.data();
        booking.id = doc.id; // set document id to lecture
        return booking;
      });

      isLoading.value = false;
      bookings.clear();
      bookings.addAll(bookingsDocs);
    });
  }

  Future<void> cancelBooking(String bookingId, String teacherId) async {
    isLoading.value = true;
    await _bookingRepo.updateBookingDocCancellation(bookingId, teacherId);
    isLoading.value = false;
  }

  Future<void> bookLecture(Lecture selectedLecture) async {
    Booking newBooking = Booking(
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
      teacherId: selectedTeacher.id!,
    );

    newBooking.lecDate = newBooking.getLectureDate();

    bool isNotFirstTimeBooking = bookings.any((booking) =>
        booking.lecDate?.day == newBooking.lecDate?.day &&
        booking.lecDate?.month == newBooking.lecDate?.month &&
        booking.lecDate?.year == newBooking.lecDate?.year &&
        booking.material.compareTo(newBooking.material) == 0 &&
        booking.lectureId.compareTo(newBooking.lectureId) == 0);

    try {
      if (!isNotFirstTimeBooking) {
        await _bookingRepo.addBooking(newBooking);
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  @override
  void onClose() {
    super.onClose();
    bookingsListener.cancel();
  }
}
