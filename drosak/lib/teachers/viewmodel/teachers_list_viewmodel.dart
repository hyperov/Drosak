import 'package:drosak/common/model/filter_models.dart';
import 'package:drosak/follows/model/repo/follow_repo.dart';
import 'package:drosak/teachers/model/teacher.dart';
import 'package:drosak/teachers/model/teachers_repo.dart';
import 'package:get/get.dart';

import '../../follows/model/entity/follow.dart';

class TeachersListViewModel extends GetxController {
  final TeachersRepo _teachersRepo = Get.put(TeachersRepo());
  final FollowRepo _followRepo = Get.put(FollowRepo());

  final RxList<Teacher> teachersList = <Teacher>[].obs;

  RxBool isLoading = false.obs;

  Teacher selectedTeacher = Teacher();

  @override
  Future<void> onReady() async {
    super.onReady();
    await getTeachersList(false);
  }

  Future<void> getTeachersList(bool isTeacherApplied,
      {String? highSchool,
      String? midSchool,
      double? minPrice,
      double? maxPrice,
      List<Rx<FilterChipModel>>? selectedMaterials}) async {
    isLoading.value = true;

    List<String>? materials = selectedMaterials
        ?.map((material) => material.value.name.value)
        .toList();

    var _teachers = await _teachersRepo.getTeachers(isTeacherApplied,
        highSchool: highSchool,
        midSchool: midSchool,
        minPrice: minPrice,
        maxPrice: maxPrice,
        selectedMaterials: materials);

    var teachersDocs = _teachers.docs.where((doc) {
      if (minPrice != null && maxPrice != null) {
        return doc.data().priceMax! <= maxPrice;
      }
      return true;
    }).where((doc) {
      if (highSchool != null && midSchool != null) {
        return doc.data().educationalLevel!.contains(midSchool);
      }
      return true;
    }).map((doc) {
      var teacher = doc.data();
      teacher.id = doc.id; // set document id to lecture
      return teacher;
    });

    isLoading.value = false;
    teachersList.clear();
    teachersList.addAll(teachersDocs);
  }

  Future<void> followTeacher() async {
    final follow = Follow(
      teacherId: selectedTeacher.id!,
      teacherName: selectedTeacher.name!,
      teacherPhotoUrl: selectedTeacher.photoUrl!,
      rating: selectedTeacher.avgRating!,
      material: selectedTeacher.material!,
      educationalLevel: selectedTeacher.educationalLevel!,
    );

    await _followRepo.addFollow(follow);
  }
}
