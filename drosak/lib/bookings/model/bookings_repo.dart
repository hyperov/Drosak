import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/bookings/model/booking.dart';
import 'package:drosak/utils/firestore_names.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:get_storage/get_storage.dart';

class BookingsRepo {
  final _storage = GetStorage();

  Future<QuerySnapshot<Booking>> getBookings() {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(_storage.read(StorageKeys.studentId))
        .collection(FireStoreNames.collectionStudentBookings)
        .withConverter<Booking>(
          fromFirestore: (snapshot, _) => Booking.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        )
        .get();
  }

  Future<void> updateBookingDocCancellation(String bookingId) async {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(_storage.read(StorageKeys.studentId))
        .collection(FireStoreNames.collectionStudentBookings)
        .doc(bookingId)
        .update({'is_canceled': true});
  }

  Future<DocumentReference<Booking>> addBooking(Booking booking) {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(_storage.read(StorageKeys.studentId))
        .collection(FireStoreNames.collectionStudentBookings)
        .withConverter<Booking>(
            fromFirestore: (snapshot, _) => Booking.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .add(booking);
  }
}
