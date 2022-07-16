// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:drosak/fav/fav.dart';
// import 'package:drosak/utils/firestore_names.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class FavRepo {
//   Future<QuerySnapshot<Fav>> getStudentFavs(String studentId) {
//     return FirebaseFirestore.instance
//         .collection(FireStoreNames.collectionStudents)
//         .doc(studentId)
//         .collection(FireStoreNames.collectionStudentFavs)
//         .withConverter<Fav>(
//             fromFirestore: (snapshot, _) => Fav.fromJson(snapshot.data()!),
//             toFirestore: (model, _) => model.toJson())
//         .get();
//   }
//
//   Future<DocumentReference<Fav>> addFav(Fav fav) async {
//     return FirebaseFirestore.instance
//         .collection(FireStoreNames.collectionStudents)
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection(FireStoreNames.collectionStudentFavs)
//         .withConverter<Fav>(
//             fromFirestore: (snapshot, _) => Fav.fromJson(snapshot.data()!),
//             toFirestore: (model, _) => model.toJson())
//         .add(fav);
//   }
//
//   Future<void> incrementFavsCountToStudent() async {
//     return FirebaseFirestore.instance
//         .collection(FireStoreNames.collectionStudents)
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .update({'favs': FieldValue.increment(1)});
//   }
//
//   Future<void> deleteFavDoc(String teacherName) async {
//     var querySnapshot = await FirebaseFirestore.instance
//         .collection(FireStoreNames.collectionStudents)
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection(FireStoreNames.collectionStudentFavs)
//         .where(FireStoreNames.followDocFieldTeacherName, isEqualTo: teacherName)
//         .get();
//
//     var batch = FirebaseFirestore.instance.batch();
//
//     batch.delete(querySnapshot.docs.first.reference);
//     var docStudent = FirebaseFirestore.instance
//         .collection(FireStoreNames.collectionStudents)
//         .doc(FirebaseAuth.instance.currentUser!.uid);
//     // decerement follows count
//     batch.update(docStudent, {'favs': FieldValue.increment(-1)});
//     await batch.commit();
//   }
// }
