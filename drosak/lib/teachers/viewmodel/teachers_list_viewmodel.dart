import 'package:drosak/follows/model/repo/follow_repo.dart';
import 'package:drosak/teachers/model/teacher.dart';
import 'package:drosak/teachers/model/teachers_repo.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../follows/model/entity/follow.dart';

class TeachersListViewModel extends GetxController {
  final TeachersRepo _teachersRepo = Get.put(TeachersRepo());
  final FollowRepo _followRepo = Get.put(FollowRepo());

  final RxList<Teacher> teachersList = <Teacher>[].obs;

  RxBool isLoading = false.obs;

  final _storage = GetStorage();

  Teacher selectedTeacher = Teacher();

  @override
  Future<void> onReady() async {
    super.onReady();
    await getTeachersList();
  }

  Future<void> getTeachersList() async {
    isLoading.value = true;

    var _teachers = await _teachersRepo.getTeachers();

    var teachersDocs = _teachers.docs.map((doc) {
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
