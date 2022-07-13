import 'package:drosak/lectures/lectures_screen.dart';
import 'package:drosak/reviews/view/reviews_screen.dart';
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
  TeacherDetailsScreen({Key? key}) : super(key: key);

  final TeachersListViewModel _teachersListViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Image.network(_teachersListViewModel.selectedTeacher.photoUrl!,
                width: 70,
                height: 70,
                fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
              return SvgPicture.asset(
                AssetsManager.profilePlaceHolder,
                width: 70,
                height: 70,
                color: Colors.white,
                fit: BoxFit.cover,
              ).marginAll(16);
            }),
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorManager.greyLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: SvgPicture.asset(
                    AssetsManager.fav,
                    color: Colors.red,
                    height: 28,
                    width: 28,
                  ),
                  onPressed: () {},
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                        padding: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        )),
                    child: Text(
                      LocalizationKeys.following.tr,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {},
                  ).marginSymmetric(horizontal: 4),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorManager.greyLight,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: SvgPicture.asset(
                    AssetsManager.star,
                    height: 28,
                    width: 28,
                  ),
                  onPressed: () {},
                ),
              ],
            ).marginSymmetric(horizontal: 48),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        const Icon(Icons.people, color: Colors.blue),
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
                ),
                Container(
                  width: 1,
                  height: 60,
                  color: Colors.grey,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        const Icon(Icons.star, color: Colors.blue),
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
                ),
              ],
            ).marginSymmetric(horizontal: 65)
          ],
        ),
        SlidingUpPanel(
          minHeight: 120,
          parallaxEnabled: true,
          parallaxOffset: .5,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(42),
          ),
          border: Border.all(
            color: Colors.deepPurpleAccent,
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
                            teacher: _teachersListViewModel.selectedTeacher),
                        ReviewsScreen(scrollController: scrollController),
                        PostsScreen(scrollController: scrollController),
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
