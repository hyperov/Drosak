import 'package:drosak/common/widgets/bottomsheet.dart';
import 'package:drosak/common/widgets/dialogs.dart';
import 'package:drosak/follows/viewmodel/follows_viewmodel.dart';
import 'package:drosak/reviews/viewmodel/reviews_viewmodel.dart';
import 'package:drosak/teachers/viewmodel/teachers_list_viewmodel.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class TeacherDetailsPersonalScreen extends StatelessWidget {
  TeacherDetailsPersonalScreen({Key? key}) : super(key: key);

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
    FirebaseCrashlytics.instance.log('TeacherDetailsScreen');
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'firebase_screen': 'teacher_details_screen',
        'firebase_screen_class': 'TeacherDetailsScreen',
      },
    );
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;

    return Scaffold(
      backgroundColor: ColorManager.redOrangeLight,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Hero(
            tag: _teachersListViewModel.selectedTeacher.id ?? 'tag',
            child: Material(
              color: Colors.transparent,
              child: Card(
                  clipBehavior: Clip.hardEdge,
                  color: Colors.deepPurple,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: ColorManager.deepPurple,
                      width: 4,
                    ),
                  ),
                  child: _teachersListViewModel.selectedTeacher.photoUrl ==
                              null ||
                          _teachersListViewModel
                              .selectedTeacher.photoUrl.isBlank!
                      ? Image.asset(
                          AssetsManager.teacher_empty_profile,
                          width: 100,
                          height: 100,
                        )
                      : FadeInImage.assetNetwork(
                          placeholder: AssetsManager.teacher_empty_profile,
                          image:
                              _teachersListViewModel.selectedTeacher.photoUrl ??
                                  '',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AssetsManager.teacher_empty_profile,
                              width: 100,
                              height: 100,
                            );
                          },
                        )),
            ),
          ),
          Text(_teachersListViewModel.selectedTeacher.name ?? 'المستر',
              textAlign: TextAlign.center,
              maxLines: 2,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.05,
            child: Marquee(
              text: _teachersListViewModel.selectedTeacher.classes == null ||
                      _teachersListViewModel.selectedTeacher.classes!.isEmpty
                  ? 'لا يوجد صف'
                  : _teachersListViewModel.selectedTeacher.classes!
                      .toString()
                      .replaceAll('[', '')
                      .replaceAll(']', '')
                      .replaceAll(',', ' - '),
              style: const TextStyle(fontSize: 18),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              blankSpace: 20,
            ),
          ),
          Text(_teachersListViewModel.selectedTeacher.material ?? '',
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: isFollowing()
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
                        ? LocalizationKeys.cancel_follow.tr
                        : LocalizationKeys.follows2.tr,
                    style: TextStyle(
                        color: isFollowing()
                            ? ColorManager.deepPurple
                            : ColorManager.redOrangeLight,
                        fontSize: 2 * unitHeightValue,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    if (isFollowing()) {
                      openDeleteDialog(_followsViewModel,
                          _teachersListViewModel.selectedTeacher.id!);
                      FirebaseCrashlytics.instance
                          .log('delete follow button clicked');
                    } else {
                      await _teachersListViewModel.followTeacher();
                      FirebaseCrashlytics.instance
                          .log('follow teacher button clicked');
                      FirebaseAnalytics.instance.logEvent(
                          name: "follow_teacher_success",
                          parameters: {
                            "teacher_id":
                                _teachersListViewModel.selectedTeacher.id,
                            "teacher_name":
                                _teachersListViewModel.selectedTeacher.name,
                          });
                    }
                  },
                ).marginSymmetric(horizontal: 8),
              )),
              Expanded(
                child: Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
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
                          FirebaseCrashlytics.instance
                              .log('rate teacher button clicked');
                          FirebaseAnalytics.instance
                              .logEvent(name: "rating_teacher_dialog");
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
                    ).marginSymmetric(horizontal: 8)),
              ),
            ],
          ).marginSymmetric(horizontal: 24),
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(66),
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
                      const Icon(Icons.people, color: ColorManager.deepPurple),
                      Text(LocalizationKeys.followers.tr,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.grey)),
                      Text(
                          _teachersListViewModel.selectedTeacher.followers
                              .toString(),
                          style: const TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ).paddingSymmetric(horizontal: 16, vertical: 16),
                ),
                Container(
                  width: 1,
                  height: 70,
                  color: ColorManager.blueDark,
                ),
                Expanded(
                    child: Column(
                  children: [
                    const Icon(Icons.star, color: ColorManager.deepPurple),
                    Text(LocalizationKeys.rating.tr,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey)),
                    Text(
                        _teachersListViewModel.selectedTeacher.avgRating
                            .toString(),
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ],
                )),
              ],
            ),
          ).marginSymmetric(horizontal: 54)
        ],
      ),
    );
  }
}
