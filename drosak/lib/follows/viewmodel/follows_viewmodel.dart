import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/entity/Follow.dart';
import '../model/repo/follow_repo.dart';

class FollowsViewModel extends GetxController {
  final _followRepo = FollowRepo();

  var follows = <Follow>[].obs;

  RxBool isFollowingTeacher = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getFollows();
  }

  getFollows() async {
    isLoading.value = true;

    var _follows = await _followRepo
        .getStudentFollows(FirebaseAuth.instance.currentUser!.uid);

    var followsDocs = _follows.docs.map((doc) {
      var follow = doc.data();
      return follow;
    });

    isLoading.value = false;
    follows.clear();
    follows.addAll(followsDocs);
  }

  void unfollow(String teacherName) {
    isLoading.value = true;
    _followRepo.unfollow(teacherName);
    isLoading.value = false;
    getFollows();
  }
}
