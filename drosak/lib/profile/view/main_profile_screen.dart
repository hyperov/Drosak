import 'package:drosak/login/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/localization/localization_keys.dart';
import 'personal_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final LoginViewModel _loginViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50),
          const CircleAvatar(
            child: Icon(Icons.person, size: 50),
            radius: 50,
          ),
          const SizedBox(height: 10),
          const Text('احمد على'),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.location_pin, color: Colors.blue),
            const Text('القاهرة - '),
            const Text('مدينة نصر'),
          ]),
          const SizedBox(height: 10),
          Text('الصف الأول الثانوى'),
          InkWell(
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text(LocalizationKeys.personal_info.tr),
                ),
              ),
              onTap: () {
                Get.to(() => PersonalProfileScreen());
              }),
          InkWell(
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ListTile(
                  leading: Icon(Icons.bookmark),
                  title: Text('الحجوزات'),
                ),
              ),
              onTap: () {
                Get.to(() => PersonalProfileScreen());
              }),
          InkWell(
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ListTile(
                  leading: Icon(Icons.favorite),
                  title: const Text('المفضلة'),
                ),
              ),
              onTap: () {
                Get.to(() => PersonalProfileScreen());
              }),
          InkWell(
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('الاعدادات'),
                ),
              ),
              onTap: () {
                Get.to(() => PersonalProfileScreen());
              }),
          InkWell(
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ListTile(
                  leading: Icon(Icons.help),
                  title: Text('مساعدة'),
                ),
              ),
              onTap: () {
                Get.to(() => PersonalProfileScreen());
              }),
          InkWell(
            child: Card(
              color: Colors.white,
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('تسجيل الخروج'),
              ),
            ),
            onTap: () {
              _loginViewModel.logout();
            },
          ),
        ],
      ),
    );
  }
}
