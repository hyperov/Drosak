import 'package:drosak/teachers/model/teacher.dart';
import 'package:drosak/teachers/model/teachers_repo.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TeachersListViewModel extends GetxController {
  final TeachersRepo _teachersRepo = Get.put(TeachersRepo());

  final RxList<Teacher> teachersList = <Teacher>[].obs;

  RxBool isLoading = false.obs;

  final _storage = GetStorage();

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
}
