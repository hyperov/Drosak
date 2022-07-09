import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../viewmodel/follows_viewmodel.dart';

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
                  ? ListView.builder(
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 24),
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          clipBehavior: Clip.none,
                                          children: [
                                            Card(
                                              color: Colors.deepPurple,
                                              elevation: 4,
                                              clipBehavior: Clip.hardEdge,
                                              shape: const CircleBorder(
                                                  side: BorderSide(
                                                      color: Colors
                                                          .deepPurpleAccent,
                                                      width: 1)),
                                              child: Obx(() => _followsViewModel
                                                      .follows[index]
                                                      .teacherPhotoUrl
                                                      .isBlank!
                                                  ? SvgPicture.asset(
                                                      AssetsManager
                                                          .profilePlaceHolder,
                                                      width: 70,
                                                      height: 70,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.network(
                                                      _followsViewModel
                                                          .follows[index]
                                                          .teacherPhotoUrl,
                                                      width: 70,
                                                      height: 70,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                      return SvgPicture.asset(
                                                        AssetsManager
                                                            .profilePlaceHolder,
                                                        width: 70,
                                                        height: 70,
                                                        color: Colors.white,
                                                        fit: BoxFit.cover,
                                                      ).marginAll(16);
                                                    })),
                                            ),
                                            Positioned(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors
                                                          .deepPurpleAccent),
                                                  borderRadius: const BorderRadius
                                                          .horizontal(
                                                      left: Radius.circular(16),
                                                      right:
                                                          Radius.circular(16)),
                                                ),
                                                child: Row(children: [
                                                  SvgPicture.asset(
                                                    AssetsManager.star,
                                                    width: 16,
                                                    height: 16,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                      _followsViewModel
                                                          .follows[index].rating
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.black)),
                                                ]),
                                              ),
                                              bottom: -5,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 32),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                _followsViewModel
                                                    .follows[index].teacherName,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(_followsViewModel
                                                .follows[index].material),
                                            Text(_followsViewModel
                                                .follows[index]
                                                .getEducationText()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    PositionedDirectional(
                                      end: 16,
                                      bottom: 16,
                                      top: 16,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          _followsViewModel.unfollow(
                                              _followsViewModel
                                                  .follows[index].teacherName);
                                        },
                                        icon: _followsViewModel
                                                .follows[index].isFollowing
                                            ? const Icon(
                                                Icons.done,
                                                color: Colors.deepPurpleAccent,
                                              )
                                            : const Icon(Icons.add,
                                                color: Colors.white),
                                        label: Text(LocalizationKeys.follows.tr,
                                            style: _followsViewModel
                                                    .follows[index].isFollowing
                                                ? const TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        Colors.deepPurpleAccent)
                                                : const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white)),
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                            side: const BorderSide(
                                                color: Colors.deepPurpleAccent),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16))),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: _followsViewModel.follows.length)
                      .paddingOnly(top: 20)
                      .marginSymmetric(horizontal: 16)
                  : const Center(child: Text("No follows found")),
        ));
  }
}
