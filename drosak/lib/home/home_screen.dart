import 'package:drosak/bookings/view/bookings_screen.dart';
import 'package:drosak/common/viewmodel/filter_viewmodel.dart';
import 'package:drosak/common/widgets/bottomsheet.dart';
import 'package:drosak/notifications/notifictations_screen.dart';
import 'package:drosak/profile/view/main_profile_screen.dart';
import 'package:drosak/teachers/teachers_list_screen.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'HomeViewModel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeViewModel _homeViewModel = Get.find();
  final FilterViewModel _filterViewModel = Get.find();

  final widgetOptions = [
    TeachersListScreen(),
    const BookingsScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  final widgetTitles = [
    LocalizationKeys.home.tr,
    LocalizationKeys.last_bookings.tr,
    LocalizationKeys.news_teachers.tr,
    LocalizationKeys.profile.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.redOrangeLight,
        floatingActionButton:
            Obx(() => _homeViewModel.bottomNavigationIndex.value == 0
                ? FloatingActionButton.extended(
                    onPressed: () {
                      showFilterBottomSheet(context, _filterViewModel);
                    },
                    icon: const Icon(Icons.filter_list),
                    backgroundColor: ColorManager.blueDark,
                    label: Text(LocalizationKeys.filter.tr),
                  )
                : Container()),
        appBar: AppBar(
          title: Obx(() => Stack(children: [
                SvgPicture.asset(
                  AssetsManager.appbarBackGround,
                ),
                Container(
                  child: Text(
                    widgetTitles
                        .elementAt(_homeViewModel.bottomNavigationIndex.value),
                    style: const TextStyle(
                        fontFamily: AssetsManager.fontFamily,
                        fontSize: 22,
                        fontWeight: FontWeight.w200),
                  ),
                  alignment: AlignmentDirectional.center,
                ),
              ], alignment: Alignment.center)),
          toolbarHeight: 100,
          titleTextStyle: const TextStyle(fontSize: 20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 4),
              ]),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
            child: GetX<HomeViewModel>(builder: (context) {
              return BottomNavigationBar(
                selectedItemColor: Colors.deepPurple.shade800,
                unselectedItemColor: Colors.grey.shade600,
                showUnselectedLabels: true,
                elevation: 0,
                iconSize: 30,
                unselectedLabelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.home),
                    label: LocalizationKeys.home.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.calendar_month),
                    label: LocalizationKeys.bookings.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.notifications),
                    label: LocalizationKeys.news.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.person),
                    label: LocalizationKeys.profile.tr,
                  )
                ],
                currentIndex: _homeViewModel.bottomNavigationIndex.value,
                onTap: (int index) {
                  _homeViewModel.bottomNavigationIndex.value = index;
                },
              );
            }),
          ),
        ),
        body: Obx(() => _homeViewModel.bottomNavigationIndex.value != 0
            ? widgetOptions
                .elementAt(_homeViewModel.bottomNavigationIndex.value)
            : SafeArea(
                child: Obx(() => widgetOptions
                    .elementAt(_homeViewModel.bottomNavigationIndex.value)),
              )));
  }
}
