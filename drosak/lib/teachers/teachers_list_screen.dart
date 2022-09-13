import 'package:drosak/common/model/empty_widget.dart';
import 'package:drosak/common/viewmodel/filter_viewmodel.dart';
import 'package:drosak/extensions/teacher_extensions.dart';
import 'package:drosak/teachers/viewmodel/teachers_list_viewmodel.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/managers/assets_manager.dart';
import '../utils/messages/logs.dart';
import 'teacher_details_screen.dart';

class TeachersListScreen extends StatelessWidget {
  TeachersListScreen({Key? key}) : super(key: key);

  TeachersListViewModel get _teachersListViewModel => Get.find();

  FilterViewModel get _filterViewModel => Get.find();
  final _storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    FirebaseCrashlytics.instance.log('TeachersListScreen');
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'firebase_screen': 'teachers_list_screen',
        'firebase_screen_class': 'TeachersListScreen',
      },
    );
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;

    return Obx(() => Scaffold(
        backgroundColor: ColorManager.redOrangeLight,
        body: _teachersListViewModel.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : _teachersListViewModel.teachersList.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: _refresh,
                    color: ColorManager.redOrangeLight,
                    backgroundColor: ColorManager.blueDark,
                    displacement: 50,
                    child: ListView.builder(
                            key: PageStorageKey<String>(
                                Logs.teachersListScrollPosition.toString()),
                            controller: _teachersListViewModel.controller,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    FirebaseAnalytics.instance.logSelectItem(
                                      itemListId: _teachersListViewModel
                                          .teachersList[index].id,
                                      itemListName: _teachersListViewModel
                                          .teachersList[index].name,
                                    );
                                    _teachersListViewModel.selectedTeacher =
                                        _teachersListViewModel
                                            .teachersList[index];
                                    await _storage.write(
                                        StorageKeys.teacherId,
                                        _teachersListViewModel
                                            .selectedTeacher.id);
                                    await _storage.write(
                                        StorageKeys.teacherRating,
                                        _teachersListViewModel
                                            .selectedTeacher.avgRating);
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
                                                Hero(
                                                  tag: _teachersListViewModel
                                                          .teachersList[index]
                                                          .id ??
                                                      'tag',
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: Card(
                                                      color: Colors.deepPurple,
                                                      elevation: 4,
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      shape: const CircleBorder(
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .deepPurpleAccent,
                                                              width: 1)),
                                                      child: Obx(() => _teachersListViewModel
                                                                  .teachersList[
                                                                      index]
                                                                  .photoUrl
                                                                  .isBlank! ||
                                                              _teachersListViewModel
                                                                      .teachersList[
                                                                          index]
                                                                      .photoUrl ==
                                                                  null
                                                          ? Image.asset(
                                                              AssetsManager
                                                                  .teacher_empty_profile,
                                                              width: 70,
                                                              height: 70,
                                                            )
                                                          : FadeInImage
                                                              .assetNetwork(
                                                              placeholder:
                                                                  AssetsManager
                                                                      .teacher_empty_profile,
                                                              image: _teachersListViewModel
                                                                  .teachersList[
                                                                      index]
                                                                  .photoUrl!,
                                                              width:
                                                                  unitHeightValue *
                                                                      8,
                                                              height:
                                                                  unitHeightValue *
                                                                      8,
                                                              // fit: BoxFit.cover,
                                                              imageErrorBuilder:
                                                                  (context,
                                                                      error,
                                                                      stackTrace) {
                                                                return Image
                                                                    .asset(
                                                                  AssetsManager
                                                                      .teacher_empty_profile,
                                                                  width: 70,
                                                                  height: 70,
                                                                );
                                                              },
                                                            )),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8,
                                                        vertical: 2),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: Colors
                                                              .deepPurpleAccent),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .horizontal(
                                                              left: Radius
                                                                  .circular(16),
                                                              right: Radius
                                                                  .circular(
                                                                      16)),
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
                                                              .teachersList[
                                                                  index]
                                                              .avgRating
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .black)),
                                                    ]),
                                                  ),
                                                  bottom: -5,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      _teachersListViewModel
                                                          .teachersList[index]
                                                          .name!,
                                                      style: TextStyle(
                                                          fontSize:
                                                              unitHeightValue *
                                                                  1.6,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      _teachersListViewModel
                                                          .teachersList[index]
                                                          .material!,
                                                      style: TextStyle(
                                                          fontSize:
                                                              unitHeightValue *
                                                                  1.8,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ColorManager
                                                              .deepPurple)),
                                                  Text(
                                                      _teachersListViewModel
                                                          .teachersList[index]
                                                          .getEducationText(),
                                                      style: TextStyle(
                                                          fontSize:
                                                              unitHeightValue *
                                                                  1.6,
                                                          color: ColorManager
                                                              .blueDark)),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    '${_teachersListViewModel.teachersList[index].priceMin} - '
                                                    '${_teachersListViewModel.teachersList[index].priceMax} ج ',
                                                    style: TextStyle(
                                                        fontSize:
                                                            unitHeightValue *
                                                                1.8,
                                                        color: ColorManager
                                                            .deepPurple,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    LocalizationKeys
                                                        .price_average.tr,
                                                    style: TextStyle(
                                                      fontSize:
                                                          unitHeightValue * 1.6,
                                                      color: ColorManager
                                                          .deepPurple,
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            // physics: const BouncingScrollPhysics(),
                            itemCount: _teachersListViewModel
                                    .teachersList.isEmpty
                                ? 0
                                : _teachersListViewModel.teachersList.length)
                        .paddingOnly(top: 20)
                        .marginSymmetric(horizontal: 16),
                  )
                : EmptyView(title: LocalizationKeys.teachers_not_found.tr)));
  }

  Future<void> _refresh() async {
    await _filterViewModel.applyFilter();
    return Future.delayed(const Duration(seconds: 0));
  }
}
