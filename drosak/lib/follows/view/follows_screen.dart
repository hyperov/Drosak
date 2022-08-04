import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodel/follows_viewmodel.dart';
import 'follow_item.dart';

class FollowsScreen extends StatelessWidget {
  const FollowsScreen({Key? key}) : super(key: key);

  FollowsViewModel get _followsViewModel => Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: ColorManager.redOrangeLight,
          body: _followsViewModel.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : _followsViewModel.follows.isNotEmpty
                  ? Obx(() => ListView.builder(
                      itemCount: _followsViewModel.follows.length,
                      itemBuilder: (context, index) {
                        return FollowItem(
                          followsViewModel: _followsViewModel,
                          index: index,
                        ).marginSymmetric(horizontal: 16);
                      }).paddingOnly(top: 20))
                  : const Center(child: Text("No follows found")),
        ));
  }
}
