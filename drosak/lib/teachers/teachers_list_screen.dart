import 'package:drosak/extensions/teacher_extensions.dart';
import 'package:drosak/teachers/viewmodel/teachers_list_viewmodel.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utils/managers/assets_manager.dart';
import 'teacher_details_screen.dart';

class TeachersListScreen extends StatelessWidget {
  const TeachersListScreen({Key? key}) : super(key: key);

  TeachersListViewModel get _teachersListViewModel => Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: ColorManager.redOrangeLight,
        body: _teachersListViewModel.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : _teachersListViewModel.teachersList.isNotEmpty
                ? ListView.builder(
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: InkWell(
                              onTap: () {
                                _teachersListViewModel.selectedTeacher =
                                    _teachersListViewModel.teachersList[index];
                                Get.to(() => TeacherDetailsScreen());
                              },
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
                                              child: Obx(() =>
                                                  _teachersListViewModel
                                                          .teachersList[index]
                                                          .photoUrl
                                                          .isBlank!
                                                      ? SvgPicture.asset(
                                                          AssetsManager
                                                              .profilePlaceHolder,
                                                          width: 50,
                                                          height: 50,
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.network(
                                                          _teachersListViewModel
                                                              .teachersList[
                                                                  index]
                                                              .photoUrl!,
                                                          width: 70,
                                                          height: 70,
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                          return SvgPicture
                                                              .asset(
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
                                                      _teachersListViewModel
                                                          .teachersList[index]
                                                          .avgRating
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
                                                _teachersListViewModel
                                                    .teachersList[index].name!,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(_teachersListViewModel
                                                .teachersList[index].material!),
                                            Text(_teachersListViewModel
                                                .teachersList[index]
                                                .getEducationText()),
                                          ],
                                        ),
                                      ],
                                    ),
                                    PositionedDirectional(
                                      end: 16,
                                      bottom: 16,
                                      top: 16,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              '${_teachersListViewModel.teachersList[index].priceMin} - ${_teachersListViewModel.teachersList[index].priceMax}'),
                                          Text(LocalizationKeys
                                              .price_average.tr),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: _teachersListViewModel.teachersList.length)
                    .paddingOnly(top: 20)
                    .marginSymmetric(horizontal: 16)
                : const Center(child: Text("No teachers found"))));
  }
}
