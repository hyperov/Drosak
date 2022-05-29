import 'package:drosak/login/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/personal_profile_screen.dart';

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
          const Text('Ahmed Ali'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  Text('المنطقة'),
                  Text('المقطم'),
                ],
              ),
              const VerticalDivider(
                thickness: 20,
                width: 20,
                indent: 20,
                endIndent: 20,
                color: Colors.redAccent,
              ),
              Column(
                children: const [
                  Text('المرحلة'),
                  Text('الثانوية'),
                ],
              ),
              const VerticalDivider(
                thickness: 2,
                color: Colors.grey,
              ),
              Column(
                children: const [
                  Text('اتابعه'),
                  Text('120'),
                ],
              )
            ],
          ),
          const SizedBox(height: 50),
          InkWell(
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const ListTile(
                  leading: Icon(Icons.person),
                  title: Text('الملف الشخصي'),
                ),
              ),
              onTap: () {
                Get.to(PersonalProfileScreen());
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
                Get.to(PersonalProfileScreen());
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
                Get.to(PersonalProfileScreen());
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
                Get.to(PersonalProfileScreen());
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
                Get.to(PersonalProfileScreen());
              }),
          const InkWell(
            child: Card(
              color: Colors.white,
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('تسجيل الخروج'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
