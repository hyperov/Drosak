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

  Future<void> incrementBookingCountToStudentAndTeacher(String teacherId) {
    var batch = FirebaseFirestore.instance.batch();

    var studentDocRef = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionStudents)
        .doc(_storage.read(StorageKeys.studentId));

    var teacherDocRef = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .doc(teacherId);

    batch.update(studentDocRef, {'bookings': FieldValue.increment(1)});
    batch.update(teacherDocRef, {'bookings': FieldValue.increment(1)});
    return batch.commit();
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
    // increment canceled bookings count
    batch.update(studentDocRef, {'bookings_canceled': FieldValue.increment(1)});
    batch.update(teacherDocRef, {'bookings_canceled': FieldValue.increment(1)});
    return batch.commit();
  }
}
