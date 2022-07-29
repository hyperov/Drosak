import 'package:drosak/common/widgets/bottomsheet.dart';
import 'package:drosak/common/widgets/dialogs.dart';
import 'package:drosak/follows/viewmodel/follows_viewmodel.dart';
import 'package:drosak/lectures/lectures_screen.dart';
import 'package:drosak/reviews/view/reviews_screen.dart';
import 'package:drosak/reviews/viewmodel/reviews_viewmodel.dart';
import 'package:drosak/teachers/viewmodel/teachers_list_viewmodel.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../posts/view/posts_screen.dart';

class TeacherDetailsScreen extends StatelessWidget {
  final _slidingUpPanelController = PanelController();

  TeacherDetailsScreen({Key? key}) : super(key: key);

  final TeachersListViewModel _teachersListViewModel = Get.find();
  final FollowsViewModel _followsViewModel = Get.find();
  final ReviewsViewModel _reviewsViewModel = Get.find();

  bool isFollowing() {
    return _followsViewModel.follows.any((follow) =>
        follow.teacherId == _teachersListViewModel.selectedTeacher.id);
  }

  bool isRated() {
    return _reviewsViewModel.reviews.any((review) =>
        review.teacherId == _teachersListViewModel.selectedTeacher.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.redOrangeLight,
      appBar: AppBar(
          title: Stack(children: [
            SvgPicture.asset(
              AssetsManager.appbarBackGround,
            ),
            Container(
              child: const Text(
                'المعلم',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          )),
      body: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            Hero(
              tag: _teachersListViewModel.selectedTeacher.id!,
              child: Material(
                color: Colors.transparent,
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: ColorManager.deepPurple,
                      width: 4,
                    ),
                  ),
                  child: Image.network(
                      _teachersListViewModel.selectedTeacher.photoUrl!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                    return SvgPicture.asset(
                      AssetsManager.profilePlaceHolder,
                      width: 70,
                      height: 70,
                      color: Colors.white,
                      fit: BoxFit.cover,
                    ).marginAll(16);
                  }),
                ),
              ),
            ),
            Text(_teachersListViewModel.selectedTeacher.name!,
                style: const TextStyle(fontSize: 30)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Marquee(
                text: _teachersListViewModel.selectedTeacher.classes!
                    .toString()
                    .replaceAll('[', '')
                    .replaceAll(']', '')
                    .replaceAll(',', ' - '),
                style: const TextStyle(fontSize: 20),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                blankSpace: 20,
              ),
            ),
            Text(_teachersListViewModel.selectedTeacher.material!,
                style: const TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: isFollowing()
                            ? Colors.white
                            : ColorManager.deepPurple,
                        padding: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            width: isFollowing() ? 2 : 0,
                            color: isFollowing()
                                ? ColorManager.deepPurple
                                : Colors.white,
                          ),
                        )),
                    child: Text(
                      isFollowing()
                          ? LocalizationKeys.delete_follow.tr
                          : LocalizationKeys.follows2.tr,
                      style: TextStyle(
                          color: isFollowing()
                              ? ColorManager.deepPurple
                              : ColorManager.redOrangeLight,
                          fontSize: 20),
                    ),
                    onPressed: () async {
                      if (isFollowing()) {
                        openDeleteDialog(_followsViewModel,
                            _teachersListViewModel.selectedTeacher.id!);
                      } else {
                        await _teachersListViewModel.followTeacher();
                      }
                    },
                  ).marginSymmetric(horizontal: 8),
                )),
                Obx(() => Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary:
                              isRated() ? Colors.grey.shade400 : Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              width: isRated() ? 2 : 2,
                              color: isRated()
                                  ? ColorManager.greyLight
                                  : ColorManager.lightPurple,
                            ),
                          ),
                        ),
                        child: SvgPicture.asset(
                          AssetsManager.star,
                          height: 28,
                          width: 28,
                          color: isRated()
                              ? Colors.white
                              : ColorManager.goldenYellow,
                        ),
                        onPressed: () {
                          if (!isRated()) {
                            showRatingTeacherBottomSheet(
                                context,
                                _reviewsViewModel,
                                _teachersListViewModel.selectedTeacher);
                          } else {
                            Get.defaultDialog(
                              radius: 16,
                              titleStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              title: LocalizationKeys.rating.tr,
                              content: Center(
                                child: Text(
                                  LocalizationKeys
                                      .review_already_rated_teacher.tr,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  softWrap: true,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ).marginSymmetric(horizontal: 16),
                              confirm: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: ColorManager.goldenYellow,
                                  padding: const EdgeInsets.all(8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(LocalizationKeys.confirm.tr,
                                        style: const TextStyle(
                                            color: ColorManager.blueDark,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold))
                                    .marginSymmetric(horizontal: 16),
                                onPressed: () => Get.back(),
                              ),
                            );
                          }
                        },
                      ).marginSymmetric(horizontal: 8),
                    )),
              ],
            ).marginSymmetric(horizontal: 48),
            const SizedBox(height: 24),
            Card(
              elevation: 4,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(
                  color: ColorManager.deepPurple,
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Icon(Icons.people,
                            color: ColorManager.deepPurple),
                        const SizedBox(height: 8),
                        Text(LocalizationKeys.followers.tr,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.grey)),
                        const SizedBox(height: 8),
                        Text(
                            _teachersListViewModel.selectedTeacher.followers
                                .toString(),
                            style: const TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ).paddingSymmetric(horizontal: 16, vertical: 16),
                  ),
                  Container(
                    width: 1,
                    height: 70,
                    color: ColorManager.blueLight,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Icon(Icons.star, color: ColorManager.deepPurple),
                        const SizedBox(height: 8),
                        Text(LocalizationKeys.rating.tr,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.grey)),
                        const SizedBox(height: 8),
                        Text(
                            _teachersListViewModel.selectedTeacher.avgRating
                                .toString(),
                            style: const TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ).paddingSymmetric(horizontal: 16, vertical: 16),
                  ),
                ],
              ),
            ).marginSymmetric(horizontal: 65)
          ],
        ),
        SlidingUpPanel(
          controller: _slidingUpPanelController,
          minHeight: 120,
          parallaxEnabled: true,
          parallaxOffset: .5,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(42),
          ),
          border: Border.all(
            color: ColorManager.deepPurple,
            width: 1,
          ),
          panelBuilder: (scrollController) {
            return DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: ColorManager.greyLight,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(48),
                      ),
                    ),
                    child: TabBar(
                      labelColor: Colors.deepPurple,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.deepPurpleAccent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(
                          text: LocalizationKeys.lectures.tr,
                          icon: const Icon(Icons.school_outlined),
                        ),
                        Tab(
                          text: LocalizationKeys.reviews.tr,
                          icon: const Icon(Icons.star_outlined),
                        ),
                        Tab(
                          text: LocalizationKeys.posts.tr,
                          icon: const Icon(Icons.theater_comedy),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        LecturesScreen(
                            scrollController: scrollController,
                            slidingUpPanelController: _slidingUpPanelController,
                            teacher: _teachersListViewModel.selectedTeacher),
                        ReviewsScreen(scrollController: scrollController),
                        PostsScreen(
                            scrollController: scrollController,
                            isFollowing: () => isFollowing()),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ]),
    );
  }
}
