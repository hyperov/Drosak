import 'package:drosak/bookings/model/booking.dart';
import 'package:drosak/bookings/model/bookings_repo.dart';
import 'package:get/get.dart';

class BookingsViewModel extends GetxController {
  final BookingsRepo _bookingRepo = Get.put(BookingsRepo());

  final RxList<Booking> bookings = <Booking>[].obs;

  RxBool isLoading = false.obs;

  Booking? selectedLecture;
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
      booking.id = doc.id; // set document id to lecture
      return booking;
    });

    isLoading.value = false;
    bookings.clear();
    bookings.addAll(bookingsDocs);
  }

  Future<void> cancelBooking(String bookingId) async {
    isLoading.value = true;
    await _bookingRepo.updateBookingDocCancellation(bookingId);
    isLoading.value = false;
    await getBookings();
  }
}
