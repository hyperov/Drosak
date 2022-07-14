import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/entity/Follow.dart';
import '../model/repo/follow_repo.dart';

class FollowsViewModel extends GetxController {
  final _followRepo = FollowRepo();

  var follows = <Follow>[].obs;

  RxBool isFollowingTeacher = false.obs;
  RxBool isLoading = false.obs;

  final followAnimatedListKey = GlobalKey<AnimatedListState>();

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

  Future<void> unfollow(String teacherName, int index) async {
    isLoading.value = true;
    await _followRepo.unfollow(teacherName);
    followAnimatedListKey.currentState?.removeItem(index, (context, animation) {
      return FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: Card(
            child: ListTile(
              title: Text(
                "item",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      );
    });
    isLoading.value = false;
    getFollows();
  }
}
