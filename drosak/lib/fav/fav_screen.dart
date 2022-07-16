// import 'package:drosak/fav/fav_viewmodel.dart';
// import 'package:drosak/follows/view/follow_item.dart';
// import 'package:drosak/utils/managers/color_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class FavScreen extends StatelessWidget {
//   FavScreen({Key? key}) : super(key: key);
//
//   final FavViewModel _favViewModel = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Scaffold(
//           backgroundColor: ColorManager.redOrangeLight,
//           body: _favViewModel.isLoading.value
//               ? const Center(child: CircularProgressIndicator())
//               : _favViewModel.fav.isNotEmpty
//                   ? RefreshIndicator(
//                       onRefresh: () async {
//                         await _favViewModel.getFollows();
//                       },
//                       child: AnimatedList(
//                           key: _favViewModel.followAnimatedListKey,
//                           initialItemCount: _favViewModel.fav.length,
//                           itemBuilder: (context, index, animation) {
//                             return SizeTransition(
//                                     sizeFactor: animation,
//                                     child: FollowItem(
//                                       followsViewModel: _favViewModel,
//                                       index: index,
//                                     ))
//                                 .paddingOnly(top: 20)
//                                 .marginSymmetric(horizontal: 16);
//                           }),
//                     )
//                   : const Center(child: Text("No follows found")),
//         ));
//   }
// }
