import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/teachers/model/teacher.dart';
import 'package:drosak/utils/firestore_names.dart';

class TeachersRepo {
  Future<QuerySnapshot<Teacher>> getTeachers(bool isFilterApplied,
      {String? highSchool,
      String? midSchool,
      double? minPrice,
      double? maxPrice,
      List<String>? selectedMaterials}) async {
    var query = FirebaseFirestore.instance
        .collection(FireStoreNames.collectionTeachers)
        .withConverter<Teacher>(
            fromFirestore: (snapshot, _) => Teacher.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson())
        .where(FireStoreNames.teacherDocFieldIsActive, isEqualTo: true);

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
      if (selectedMaterials != null) {
        query = query.where(FireStoreNames.teacherDocFieldMaterial,
            whereIn: selectedMaterials);
      }

      if (minPrice != null) {
        query = query.where(FireStoreNames.teacherDocFieldMinPrice,
            isGreaterThanOrEqualTo: minPrice);
      }

      if (maxPrice != null) {
        if (minPrice == null) {
          query = query.where(FireStoreNames.teacherDocFieldMaxPrice,
              isLessThanOrEqualTo: maxPrice);
        }
      }
    }
    return await query.get();
  }
}
