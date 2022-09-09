import 'package:drosak/follows/viewmodel/follows_viewmodel.dart';
import 'package:drosak/lectures/lectures_screen.dart';
import 'package:drosak/reviews/view/reviews_screen.dart';
import 'package:drosak/reviews/viewmodel/reviews_viewmodel.dart';
import 'package:drosak/teachers/teacher_details_personal_screen.dart';
import 'package:drosak/teachers/viewmodel/teachers_list_viewmodel.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../posts/view/posts_screen.dart';

class TeacherDetailsScreen extends StatelessWidget {
  TeacherDetailsScreen({Key? key}) : super(key: key);

  final TeachersListViewModel _teachersListViewModel = Get.find();
  final FollowsViewModel _followsViewModel = Get.find();
  final ReviewsViewModel _reviewsViewModel = Get.find();

  final _slidingUpPanelController = PanelController();

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
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: ColorManager.redOrangeLight,
        appBar: AppBar(
            title: Stack(children: [
              SvgPicture.asset(
                AssetsManager.appbarBackGround,
              ),
              Container(
                child: Text(
                  LocalizationKeys.teacher.tr,
                  style: const TextStyle(
                      fontFamily: AssetsManager.fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                alignment: AlignmentDirectional.centerStart,
              ),
            ], alignment: Alignment.center),
            toolbarHeight: 100,
            titleTextStyle: const TextStyle(fontSize: 20),
            bottom: TabBar(
              labelColor: ColorManager.redOrangeDark,
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  text: LocalizationKeys.teacher.tr,
                  icon: const Icon(Icons.person),
                ),
                Tab(
                  text: LocalizationKeys.lectures.tr,
                  icon: const Icon(Icons.school_outlined),
                ),
                Tab(
                  text: LocalizationKeys.reviews.tr,
                  icon: const Icon(Icons.star_outlined),
                ),
                Tab(
                  text: LocalizationKeys.news.tr,
                  icon: const Icon(Icons.theater_comedy),
                )
              ],
            )),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  TeacherDetailsPersonalScreen(),
                  LecturesScreen(
                      slidingUpPanelController: _slidingUpPanelController,
                      teacher: _teachersListViewModel.selectedTeacher),
                  ReviewsScreen(),
                  PostsScreen(isFollowing: () => isFollowing()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
