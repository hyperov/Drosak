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

  Future<void> incrementBookingCountToStudent() {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(_storage.read(StorageKeys.studentId))
        .update({'bookings': FieldValue.increment(1)});
  }

  Future<void> updateBookingDocCancellation(String bookingId) async {
    var batch = FirebaseFirestore.instance.batch();

    var docBooking = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(_storage.read(StorageKeys.studentId))
        .collection(FireStoreNames.collectionStudentBookings)
        .doc(bookingId);

    batch.update(docBooking, {'is_canceled': true});

    var docStudent = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(_storage.read(StorageKeys.studentId));
    // increment canceled bookings count
    batch.update(docStudent, {'bookings_canceled': FieldValue.increment(1)});
    return batch.commit();
  }
}
