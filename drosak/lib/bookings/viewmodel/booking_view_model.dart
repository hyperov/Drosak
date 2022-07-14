import 'package:drosak/bookings/model/bookings_repo.dart';
import 'package:drosak/lectures/model/entity/lecture.dart';
import 'package:get/get.dart';

class BookingsViewModel extends GetxController {
  final BookingsRepo _bookingRepo = Get.put(BookingsRepo());

  final RxList<Lecture> bookings = <Lecture>[].obs;

  RxBool isLoading = false.obs;

  Lecture? selectedLecture;
  int selectedIndex = -1;

  @override
  onReady() async {
    super.onReady();
    await getBookings();
  }

  getBookings() async {
    isLoading.value = true;

    var _bookings = await _bookingRepo.getBookings();

    var bookingsDocs = _bookings.docs.map((doc) {
      var booking = doc.data();
      return booking;
    });

    isLoading.value = false;
    bookings.clear();
    bookings.addAll(bookingsDocs);
  }
}
