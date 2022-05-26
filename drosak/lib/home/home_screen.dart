import 'package:drosak/login/viewmodel/login_view_model.dart';
import 'package:drosak/profile/main_profile_screen.dart';
import 'package:drosak/teachers/teachers_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'HomeViewModel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);

  final LoginViewModel _loginViewModel = Get.find();
  final HomeViewModel _homeViewModel = Get.find();

  final String title;

  final widgetOptions = [
    const TeachersList(),
    ProfileScreen(),
    ProfileScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("hello"),
      ),
      bottomNavigationBar: SafeArea(
        child: GetX<HomeViewModel>(builder: (context) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people, color: Colors.black),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications, color: Colors.black),
                label: 'notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.black),
                label: 'Profile',
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
