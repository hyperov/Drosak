import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/teachers/model/teacher.dart';
import 'package:drosak/utils/firestore_names.dart';

class TeachersRepo {
  Future<QuerySnapshot<Teacher>> getTeachers(bool isFilterApplied,
      {String? highSchool,
      String? midSchool,
      double? minPrice,
      double? maxPrice,
      List<String>? materials,
      List<String>? areas}) async {
    var query = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .withConverter<Teacher>(
            fromFirestore: (snapshot, _) => Teacher.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .where(FireStoreNames.teacherDocFieldIsActive, isEqualTo: true);

    query = _applyFiltersToTeachersQuery(true, null, isFilterApplied, query,
        highSchool, midSchool, minPrice, maxPrice, materials, areas);
    return query.get();
  }

  Future<QuerySnapshot<Teacher>> getNextTeachers(
      DocumentSnapshot teacherPrevSnapShot, bool isFilterApplied,
      {String? highSchool,
      String? midSchool,
      double? minPrice,
      double? maxPrice,
      List<String>? materials,
      List<String>? areas}) async {
    var query = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .withConverter<Teacher>(
            fromFirestore: (snapshot, _) => Teacher.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .where(FireStoreNames.teacherDocFieldIsActive, isEqualTo: true);

    query = _applyFiltersToTeachersQuery(
        false,
        teacherPrevSnapShot,
        isFilterApplied,
        query,
        highSchool,
        midSchool,
        minPrice,
        maxPrice,
        materials,
        areas);
    return query.get();
  }

  Query<Teacher> _applyFiltersToTeachersQuery(
      bool isFirstQuery,
      DocumentSnapshot? teacherPrevSnapShot,
      bool isFilterApplied,
      Query<Teacher> query,
      String? highSchool,
      String? midSchool,
      double? minPrice,
      double? maxPrice,
      List<String>? materials,
      List<String>? areas) {
    if (isFilterApplied) {
      //todo change highschool and midschool to map {highschool: true, midschool: false}
      //to optimize filter

      //set orderby
      if (minPrice != null && maxPrice != null) {
        query = query.orderBy(FireStoreNames.teacherDocFieldMinPrice);
      } else if (minPrice != null && maxPrice == null) {
        query = query.orderBy(FireStoreNames.teacherDocFieldMinPrice);
      } else if (minPrice == null && maxPrice != null) {
        query = query.orderBy(FireStoreNames.teacherDocFieldMaxPrice);
      } else {
        query = query.orderBy(FireStoreNames.teacherDocFieldName);
      }

      if (highSchool != null) {
        query = query.where(FireStoreNames.teacherDocFieldEducationLevel,
            arrayContains: highSchool);

        var isOneFilter = midSchool == null &&
            minPrice == null &&
            maxPrice == null &&
            materials == null &&
            areas == null;

        query = isFirstQuery
            ? isOneFilter
                ? query.limit(10)
                : query
            : query.startAfterDocument(teacherPrevSnapShot!).limit(10);
      }
      if (midSchool != null) {
        if (highSchool == null) {
          query = query.where(FireStoreNames.teacherDocFieldEducationLevel,
              arrayContains: midSchool);

          var isOneFilter = minPrice == null &&
              maxPrice == null &&
              materials == null &&
              areas == null;

          query = isFirstQuery
              ? isOneFilter
                  ? query.limit(
                      10) //if this is the only filter applied then limit to 10 safely
                  : query
              : query.startAfterDocument(teacherPrevSnapShot!).limit(10);
        }
      }

      if (minPrice != null) {
        query = query.where(FireStoreNames.teacherDocFieldMinPrice,
            isGreaterThanOrEqualTo: minPrice);

        var isOneFilter = highSchool == null &&
            midSchool == null &&
            maxPrice == null &&
            materials == null &&
            areas == null;

        query = isFirstQuery
            ? isOneFilter
                ? query.limit(10)
                : query
            : query.startAfterDocument(teacherPrevSnapShot!).limit(10);
      }

      if (maxPrice != null) {
        if (minPrice == null) {
          query = query.where(FireStoreNames.teacherDocFieldMaxPrice,
              isLessThanOrEqualTo: maxPrice);

          var isOneFilter = highSchool == null &&
              midSchool == null &&
              materials == null &&
              areas == null;

          query = isFirstQuery
              ? isOneFilter
                  ? query.limit(10)
                  : query
              : query.startAfterDocument(teacherPrevSnapShot!).limit(10);
        }
      }
      if (highSchool == null &&
          midSchool == null &&
          minPrice == null &&
          maxPrice == null &&
          materials == null &&
          areas == null) {
        query = isFirstQuery
            ? query.limit(10)
            : query.startAfterDocument(teacherPrevSnapShot!).limit(10);
      } else if (highSchool == null &&
          midSchool == null &&
          minPrice == null &&
          maxPrice == null) {
        query = isFirstQuery
            ? query
            : query.startAfterDocument(teacherPrevSnapShot!).limit(10);
      }
    } else {
      query = query.orderBy(FireStoreNames.teacherDocFieldName);

      query = isFirstQuery
          ? query.limit(10)
          : query.startAfterDocument(teacherPrevSnapShot!).limit(10);
    }
    return query;
  }
}
