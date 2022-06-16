import 'package:drosak/common/viewmodel/filter_viewmodel.dart';
import 'package:drosak/common/widgets/bottomsheet.dart';
import 'package:drosak/follows/view/follows_screen.dart';
import 'package:drosak/login/viewmodel/login_view_model.dart';
import 'package:drosak/notifications/notifictations_screen.dart';
import 'package:drosak/profile/view/main_profile_screen.dart';
import 'package:drosak/teachers/teachers_list_screen.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'HomeViewModel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final LoginViewModel _loginViewModel = Get.find();
  final HomeViewModel _homeViewModel = Get.find();
  final FilterViewModel _filterViewModel = Get.find();

  final String title;

  final widgetOptions = [
    const TeachersList(),
    FollowsScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];

  final widgetTitles = [
    LocalizationKeys.home.tr,
    LocalizationKeys.follows.tr,
    LocalizationKeys.notifications.tr,
    LocalizationKeys.profile.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Obx(() => Text(widgetTitles
            .elementAt(_homeViewModel.bottomNavigationIndex.value))),
        actions: [
          IconButton(
            icon: Obx(() => Visibility(
                  visible: _homeViewModel.bottomNavigationIndex.value == 0,
                  child: const Tooltip(
                    message: "Filter",
                    showDuration: Duration(seconds: 1),
                    child: Icon(
                      Icons.filter_list,
                    ),
                  ),
                )),
            onPressed: () {
              showFilterBottomSheet(_filterViewModel);
            },
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: GetX<HomeViewModel>(builder: (context) {
          return BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home, color: Colors.black),
                label: LocalizationKeys.home.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.people, color: Colors.black),
                label: LocalizationKeys.follows.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.notifications, color: Colors.black),
                label: LocalizationKeys.notifications.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person, color: Colors.black),
                label: LocalizationKeys.profile.tr,
              )
            ],
            currentIndex: _homeViewModel.bottomNavigationIndex.value,
            selectedItemColor: Colors.amber[800],
            onTap: (int index) {
              print(index);
              _homeViewModel.bottomNavigationIndex.value = index;
            },
          );
        }),
      ),
      body: Obx(() =>
          widgetOptions.elementAt(_homeViewModel.bottomNavigationIndex.value)),
    );
  }
}
