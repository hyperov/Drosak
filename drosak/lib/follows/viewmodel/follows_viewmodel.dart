import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/entity/follow.dart';
import '../model/repo/follow_repo.dart';

class FollowsViewModel extends GetxController {
  final _followRepo = FollowRepo();

  var follows = <Follow>[].obs;

  RxBool isFollowingTeacher = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getFollows();
  }

  Future<void> getFollows() async {
    isLoading.value = true;

    var _followsStream =
        _followRepo.getStudentFollows(FirebaseAuth.instance.currentUser!.uid);

    _followsStream.listen((_follows) {
      var followsDocs = _follows.docs.map((doc) {
        var follow = doc.data();
        return follow;
      });

      isLoading.value = false;
      follows.clear();
      follows.addAll(followsDocs);
    }, onError: (e) {
      isLoading.value = false;
      print(e);
    });
  }

  Future<void> unfollowTeacher(String teacherId) async {
    isLoading.value = true;
    await _followRepo.deleteFollowDoc(teacherId);
    isLoading.value = false;
  }
}
