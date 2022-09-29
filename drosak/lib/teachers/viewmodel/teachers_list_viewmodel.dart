import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/common/model/filter_models.dart';
import 'package:drosak/follows/model/repo/follow_repo.dart';
import 'package:drosak/teachers/model/teacher.dart';
import 'package:drosak/teachers/model/teachers_repo.dart';
import 'package:drosak/utils/firestore_names.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../follows/model/entity/follow.dart';

class TeachersListViewModel extends GetxController {
  final TeachersRepo _teachersRepo = Get.put(TeachersRepo());
  final FollowRepo _followRepo = Get.put(FollowRepo());

  final RxList<Teacher> teachersList = <Teacher>[].obs;

  RxBool isLoading = false.obs;

  Teacher selectedTeacher = Teacher();
  final GetStorage _storage = GetStorage();

  ScrollController controller = ScrollController();

  late List<QueryDocumentSnapshot<Teacher>> teachersDocs;

  String? selectedFilterHighSchool;
  String? selectedFilterMidSchool;
  double? selectedFilterMinPrice;
  double? selectedFilterMaxPrice;
  List<String>? selectedFilterMaterials;
  List<String>? selectedFilterAreas;

  bool globalIsFilterApplied = false;

  @override
  Future<void> onReady() async {
    super.onReady();
    controller.addListener(_scrollListener);
    await getTeachersList(false);
  }

  Future<void> getTeachersList(bool isTeacherApplied,
      {String? highSchool,
      String? midSchool,
      double? minPrice,
      double? maxPrice,
      List<Rx<FilterChipModel>>? selectedMaterials,
      List<Rx<FilterChipModel>>? selectedAreas}) async {
    isLoading.value = true;

    List<String>? materials = selectedMaterials
        ?.map((material) => material.value.name.value)
        .toList();

    List<String>? areas =
        selectedAreas?.map((area) => area.value.name.value).toList();

    //save filters
    globalIsFilterApplied = isTeacherApplied;
    selectedFilterHighSchool = highSchool;
    selectedFilterMidSchool = midSchool;
    selectedFilterMinPrice = minPrice;
    selectedFilterMaxPrice = maxPrice;
    selectedFilterMaterials = materials;
    selectedFilterAreas = areas;

    var _teacherQuerySnapshot = await _teachersRepo.getTeachers(
        isTeacherApplied,
        highSchool: highSchool,
        midSchool: midSchool,
        minPrice: minPrice,
        maxPrice: maxPrice,
        materials: materials,
        areas: areas);

    teachersDocs = _teacherQuerySnapshot.docs.where((doc) {
      if (minPrice != null && maxPrice != null) {
        return doc.data().priceMax! >= minPrice &&
            doc.data().priceMin! <= maxPrice;
      }
      return true;
    }).where((doc) {
      if (highSchool != null && midSchool != null) {
        return doc.data().educationalLevel!.contains(midSchool);
      }
      return true;
    }).where((doc) {
      if (areas != null) {
        bool isAreaExist = false;
        for (var area in areas) {
          var selectedFilterArea = area;
          isAreaExist =
              doc.data().areasOfLectures!.contains(selectedFilterArea);
          if (isAreaExist) return true;
        }
        return isAreaExist;
      }
      return true;
    }).where((doc) {
      if (materials != null) {
        bool isMaterialExist = false;
        for (var material in materials) {
          var selectedFilterMaterial = material;
          isMaterialExist =
              doc.data().materials!.contains(selectedFilterMaterial);
          if (isMaterialExist) return true;
        }
        return isMaterialExist;
      }
      return true;
    }).toList();

    var teachers = teachersDocs.map((doc) {
      var teacher = doc.data();
      teacher.id = doc.id; // set document id to lecture
      return teacher;
    });

    isLoading.value = false;
    // var randomList = teachers.toList().shuffle();
    teachersList.clear();
    teachersList.addAll(teachers);
    teachersList.shuffle();
  }

  Future<void> getNextTeachersList() async {
    var _teacherQuerySnapshot = await _teachersRepo.getNextTeachers(
        teachersDocs.last, globalIsFilterApplied,
        highSchool: selectedFilterHighSchool,
        midSchool: selectedFilterMidSchool,
        minPrice: selectedFilterMinPrice,
        maxPrice: selectedFilterMaxPrice,
        materials: selectedFilterMaterials,
        areas: selectedFilterAreas);

    var teachersDocsNew = _teacherQuerySnapshot.docs.where((doc) {
      if (selectedFilterMinPrice != null && selectedFilterMaxPrice != null) {
        return doc.data().priceMax! >= selectedFilterMinPrice! &&
            doc.data().priceMin! <= selectedFilterMaxPrice!;
      }
      return true;
    }).where((doc) {
      if (selectedFilterHighSchool != null && selectedFilterMidSchool != null) {
        return doc.data().educationalLevel!.contains(selectedFilterMidSchool);
      }
      return true;
    }).where((doc) {
      if (selectedFilterAreas != null) {
        bool isAreaExist = false;
        for (var area in selectedFilterAreas!) {
          var selectedFilterArea = area;
          isAreaExist =
              doc.data().areasOfLectures!.contains(selectedFilterArea);
          if (isAreaExist) return true;
        }
        return isAreaExist;
      }
      return true;
    }).where((doc) {
      if (selectedFilterMaterials != null) {
        bool isMaterialExist = false;
        for (var material in selectedFilterMaterials!) {
          var selectedFilterMaterial = material;
          isMaterialExist =
              doc.data().materials!.contains(selectedFilterMaterial);
          if (isMaterialExist) return true;
        }
        return isMaterialExist;
      }
      return true;
    }).toList();

    teachersDocs.addAll(teachersDocsNew);
    teachersDocsNew.shuffle();
    var teachers = teachersDocsNew.map((doc) {
      var teacher = doc.data();
      teacher.id = doc.id; // set document id to lecture
      return teacher;
    });

    isLoading.value = false;
    teachersList.addAll(teachers);
  }

  Future<void> followTeacher() async {
    final follow = Follow(
      teacherId: selectedTeacher.id!,
      teacherName: selectedTeacher.name ?? '',
      teacherPhotoUrl: selectedTeacher.photoUrl ?? '',
      rating: selectedTeacher.avgRating!,
      material: selectedTeacher.material!,
      educationalLevel: selectedTeacher.educationalLevel!,
      studentFcmToken: _storage.read(StorageKeys.fcmToken),
      studentRef: FirebaseFirestore.instance
          .collection(FireStoreNames.collectionStudents)
          .doc(FirebaseAuth.instance.currentUser!.uid),
    );

    await _followRepo.addFollow(follow);
  }

  Future<void> _scrollListener() async {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      print("at the end of list");
      await getNextTeachersList();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    controller.dispose();
  }
}
