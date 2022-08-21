import 'package:drosak/common/model/empty_widget.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          appBar: AppBar(
            title: Stack(children: [
              SvgPicture.asset(
                AssetsManager.appbarBackGround,
              ),
              Container(
                child: Text(
                  LocalizationKeys.follows.tr,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                alignment: AlignmentDirectional.centerStart,
              ),
            ], alignment: Alignment.center),
            toolbarHeight: 100,
            titleTextStyle: const TextStyle(fontSize: 20),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
          ),
          body: _followsViewModel.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : _followsViewModel.follows.isNotEmpty
                  ? Obx(() => ListView.builder(
                      itemCount: _followsViewModel.follows.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return FollowItem(
                          followsViewModel: _followsViewModel,
                          index: index,
                        ).marginSymmetric(horizontal: 16);
                      }).paddingOnly(top: 20))
                  : EmptyView(title: LocalizationKeys.noFollows.tr),
        ));
  }
}
