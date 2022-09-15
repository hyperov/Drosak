import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/bookings/model/booking.dart';
import 'package:drosak/utils/firestore_names.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:get_storage/get_storage.dart';

class BookingsRepo {
  final _storage = GetStorage();

  Stream<QuerySnapshot<Booking>> getBookings() {
    return FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(_storage.read(StorageKeys.studentId))
        .collection(FireStoreNames.collectionStudentBookings)
        .withConverter<Booking>(
          fromFirestore: (snapshot, _) => Booking.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy(FireStoreNames.bookingDocFieldLecDate, descending: true)
        .snapshots();
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

  Future<void> updateBookingDocCancellation(
      String bookingId, String teacherId) async {
    var batch = FirebaseFirestore.instance.batch();

    var docBooking = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(_storage.read(StorageKeys.studentId))
        .collection(FireStoreNames.collectionStudentBookings)
        .doc(bookingId);

    batch.update(docBooking, {'is_canceled': true});

    var studentDocRef = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(_storage.read(StorageKeys.studentId));

    var teacherDocRef = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(teacherId);

    var appStatsDocRef = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionAppStatistics)
        .doc(FireStoreNames.documentAppStatistics);
    // increment canceled bookings count
    batch.update(studentDocRef, {'bookings_canceled': FieldValue.increment(1)});
    batch.update(teacherDocRef, {'bookings_canceled': FieldValue.increment(1)});
    batch
        .update(appStatsDocRef, {'bookings_canceled': FieldValue.increment(1)});

    return batch.commit();
  }
}
