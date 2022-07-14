import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodel/follows_viewmodel.dart';
import 'follow_item.dart';

class FollowsScreen extends StatelessWidget {
  FollowsScreen({Key? key}) : super(key: key);

  final FollowsViewModel _followsViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: ColorManager.redOrangeLight,
          body: _followsViewModel.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : _followsViewModel.follows.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: () async {
                        await _followsViewModel.getFollows();
                      },
                      child: AnimatedList(
                          key: _followsViewModel.followAnimatedListKey,
                          initialItemCount: _followsViewModel.follows.length,
                          itemBuilder: (context, index, animation) {
                            return SizeTransition(
                                    sizeFactor: animation,
                                    child: FollowItem(
                                      followsViewModel: _followsViewModel,
                                      index: index,
                                    ))
                                .paddingOnly(top: 20)
                                .marginSymmetric(horizontal: 16);
                          }),
                    )
                  : const Center(child: Text("No follows found")),
        ));
  }
}
