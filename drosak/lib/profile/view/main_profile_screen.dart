import 'package:drosak/follows/view/follows_screen.dart';
import 'package:drosak/profile/viewmodel/profile_view_model.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/localization/localization_keys.dart';
import '../../utils/managers/assets_manager.dart';
import 'personal_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  ProfileViewModel get _profileViewModel => Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.redOrangeLight,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Hero(
              tag: 'profile_image_tag',
              child: Card(
                  color: Colors.deepPurple,
                  elevation: 4,
                  clipBehavior: Clip.hardEdge,
                  shape: const CircleBorder(),
                  child: Obx(() =>
                      _profileViewModel.selectedProfileImageUrl.isEmpty
                          ? Image.asset(
                              AssetsManager.student_empty_profile,
                              width: 100,
                              height: 100,
                            )
                          : Image.network(
                              _profileViewModel.selectedProfileImageUrl.value,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                AssetsManager.student_empty_profile,
                                width: 100,
                                height: 100,
                              );
                            }))),
            ),
            Obx(() => Text(_profileViewModel.nameObserver.value,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, color: Colors.deepPurpleAccent),
                const SizedBox(width: 4),
                Obx(() => Text(_profileViewModel.selectedGovernmentName.value,
                    style: const TextStyle(fontSize: 16))),
                const Text(' - '),
                Obx(() => Text(_profileViewModel.selectedAreaName.value,
                    style: const TextStyle(fontSize: 16))),
              ],
            ),
            Obx(() => Text(
                  _profileViewModel.selectedClassText.isBlank!
                      ? 'لا يوجد صف'
                      : _profileViewModel.selectedClassText.value,
                  style: const TextStyle(fontSize: 18),
                )),
            const SizedBox(height: 24),
            Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  Get.to(() => PersonalProfileScreen());
                },
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.deepPurple),
                  title: Text(
                    LocalizationKeys.personal_info.tr,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  Get.to(() => const FollowsScreen());
                },
                child: ListTile(
                  leading: const Icon(Icons.people, color: Colors.deepPurple),
                  title: Text(LocalizationKeys.follows.tr,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  // Get.to(() => const SettingsScreen());
                },
                child: ListTile(
                  leading: const Icon(Icons.settings, color: Colors.deepPurple),
                  title: Text(LocalizationKeys.settings.tr,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {},
                child: const ListTile(
                  leading: Icon(Icons.help, color: Colors.deepPurple),
                  title: Text('مساعدة',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              LocalizationKeys.app_logout.tr,
                            ),
                            content:
                                Text(LocalizationKeys.logout_confirmation.tr),
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
                                  Navigator.pop(context);
                                  _profileViewModel.logout();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  child: ListTile(
                    leading:
                        const Icon(Icons.exit_to_app, color: Colors.deepPurple),
                    title: Text(LocalizationKeys.app_logout.tr,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ],
        ).marginOnly(bottom: 16),
      ),
    );
  }
}
