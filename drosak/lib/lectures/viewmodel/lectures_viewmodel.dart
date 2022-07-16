import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/storage_keys.dart';
import '../model/entity/lecture.dart';
import '../model/repo/lectures_repo.dart';

class LecturesViewModel extends GetxController {
  final LecturesRepo _lecturesRepo = Get.put(LecturesRepo());

  final RxList<Lecture> lectures = <Lecture>[].obs;

  RxBool isLoading = false.obs;

  final _storage = GetStorage();

  int selectedIndex = -1;

  @override
  onReady() async {
    super.onReady();
    await getLectures();
  }

  getLectures() async {
    isLoading.value = true;

    String? teacherId = _storage.read<String>(StorageKeys.teacherId);

    var _lectures = await _lecturesRepo.getLectures(teacherId!);

    var lecturesDocs = _lectures.docs.map((doc) {
      var lecture = doc.data();
      lecture.id = doc.id; // set document id to lecture
      return lecture;
    });

    isLoading.value = false;
    lectures.clear();
    lectures.addAll(lecturesDocs);
  }
}
