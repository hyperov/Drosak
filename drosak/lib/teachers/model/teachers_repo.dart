import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/teachers/model/teacher.dart';
import 'package:drosak/utils/firestore_names.dart';

class TeachersRepo {
  Future<QuerySnapshot<Teacher>> getTeachers(bool isFilterApplied,
      {String? highSchool,
      String? midSchool,
      double? minPrice,
      double? maxPrice}) async {
    var query = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .withConverter<Teacher>(
            fromFirestore: (snapshot, _) => Teacher.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .where(FireStoreNames.teacherDocFieldIsActive, isEqualTo: true)
        .orderBy(FireStoreNames.teacherDocFieldName)
        .limit(10);

    query = _applyFiltersToTeachersQuery(
        isFilterApplied, query, highSchool, midSchool, minPrice, maxPrice);
    return query.get();
  }

  Future<QuerySnapshot<Teacher>> getNextTeachers(
      DocumentSnapshot teacherPrevSnapShot, bool isFilterApplied,
      {String? highSchool,
      String? midSchool,
      double? minPrice,
      double? maxPrice}) async {
    var query = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .withConverter<Teacher>(
            fromFirestore: (snapshot, _) => Teacher.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .where(FireStoreNames.teacherDocFieldIsActive, isEqualTo: true)
        .orderBy(FireStoreNames.teacherDocFieldName)
        .startAfterDocument(teacherPrevSnapShot)
        .limit(10);

    query = _applyFiltersToTeachersQuery(
        isFilterApplied, query, highSchool, midSchool, minPrice, maxPrice);
    return query.get();
  }

  Query<Teacher> _applyFiltersToTeachersQuery(
      bool isFilterApplied,
      Query<Teacher> query,
      String? highSchool,
      String? midSchool,
      double? minPrice,
      double? maxPrice) {
    if (isFilterApplied) {
      if (highSchool != null) {
        query = query.where(FireStoreNames.teacherDocFieldEducationLevel,
            arrayContains: highSchool);
      }
      if (midSchool != null) {
        if (highSchool == null) {
          query = query.where(FireStoreNames.teacherDocFieldEducationLevel,
              arrayContains: midSchool);
        }
      }

      if (minPrice != null) {
        query = query.where(FireStoreNames.teacherDocFieldMaxPrice,
            isGreaterThanOrEqualTo: minPrice);
      }

      if (maxPrice != null) {
        if (minPrice == null) {
          query = query.where(FireStoreNames.teacherDocFieldMinPrice,
              isLessThanOrEqualTo: maxPrice);
        }
      }
    }
    return query;
  }
}
