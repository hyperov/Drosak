// import 'package:drosak/fav/fav.dart';
// import 'package:drosak/follows/view/follow_item.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'fav_repo.dart';
//
// class FavViewModel extends GetxController {
//   final _favRepo = FavRepo();
//
//   var fav = <Fav>[].obs;
//
//   RxBool isFollowingTeacher = false.obs;
//   RxBool isLoading = false.obs;
//
//   final followAnimatedListKey = GlobalKey<AnimatedListState>();
//
//   @override
//   void onInit() {
//     super.onInit();
//     getFollows();
//   }
//
//   getFollows() async {
//     isLoading.value = true;
//
//     var _follows =
//         await _favRepo.getStudentFavs(FirebaseAuth.instance.currentUser!.uid);
//
//     var favsDocs = _follows.docs.map((doc) {
//       var follow = doc.data();
//       return follow;
//     });
//
//     isLoading.value = false;
//     fav.clear();
//     fav.addAll(favsDocs);
//   }
//
//   Future<void> unfollowTeacher(String teacherName, int index) async {
//     isLoading.value = true;
//     await _favRepo.deleteFavDoc(teacherName);
//     fav.removeAt(index);
//     followAnimatedListKey.currentState?.removeItem(index, (context, animation) {
//       return FadeTransition(
//         opacity: animation,
//         child: SizeTransition(
//           sizeFactor: animation,
//           child: FollowItem(followsViewModel: this, index: index),
//         ),
//       );
//     });
//     isLoading.value = false;
//     // getFollows();
//   }
// }
