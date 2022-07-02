import 'package:drosak/login/viewmodel/login_view_model.dart';
import 'package:drosak/profile/viewmodel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/localization/localization_keys.dart';
import 'personal_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final LoginViewModel _loginViewModel = Get.find();

  ProfileViewModel get _profileViewModel => Get.find();

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
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Icon(Icons.location_pin, color: Colors.blue),
            Text('القاهرة - '),
            Text('مدينة نصر'),
          ]),
          const SizedBox(height: 10),
          const Text('الصف الأول الثانوى'),
          InkWell(
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(Icons.person),
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
            child: const Card(
              color: Colors.white,
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('تسجيل الخروج'),
              ),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(LocalizationKeys.app_logout.tr),
                      content: Text(LocalizationKeys.logout_confirmation.tr),
                      actions: [
                        ElevatedButton(
                          child: Text(LocalizationKeys.app_cancel.tr),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        ElevatedButton(
                          child: Text(LocalizationKeys.app_logout.tr),
                          onPressed: () {
                            Get.back();
                            _profileViewModel.logout();
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
