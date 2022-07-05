import 'package:drosak/login/viewmodel/login_view_model.dart';
import 'package:drosak/profile/viewmodel/profile_view_model.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

import '../../utils/localization/localization_keys.dart';
import '../../utils/managers/assets_manager.dart';
import 'personal_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final LoginViewModel _loginViewModel = Get.find();

  ProfileViewModel get _profileViewModel => Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.redOrangeLight,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Hero(
                    tag: 'profile_image_tag',
                    child: Card(
                        color: Colors.deepPurple,
                        elevation: 4,
                        clipBehavior: Clip.hardEdge,
                        shape: const CircleBorder(),
                        child: Obx(() => _profileViewModel
                                .selectedProfileImageUrl.isBlank!
                            ? SvgPicture.asset(
                                AssetsManager.profilePlaceHolder,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                _profileViewModel.selectedProfileImageUrl.value,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                return SvgPicture.asset(
                                  AssetsManager.profilePlaceHolder,
                                  width: 70,
                                  height: 70,
                                  color: Colors.white,
                                  fit: BoxFit.cover,
                                ).marginAll(16);
                              }))),
                  ),
                ),
                Obx(() => Text(_profileViewModel.nameObserver.value,
                    style: const TextStyle(fontSize: 30))),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Obx(() => Marquee(
                        text: _profileViewModel.selectedClass.isBlank!
                            ? 'لا يوجد صف'
                            : _profileViewModel.selectedClass.value,
                        style: const TextStyle(fontSize: 20),
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        blankSpace: 20,
                      )),
                ),
              ]),
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
                    leading: const Icon(Icons.person),
                    title: Text(LocalizationKeys.personal_info.tr),
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
                    leading: const Icon(Icons.settings),
                    title: Text(LocalizationKeys.settings.tr),
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
                    leading: Icon(Icons.help),
                    title: Text('مساعدة'),
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
                            title: Text(LocalizationKeys.app_logout.tr),
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
                    leading: const Icon(Icons.exit_to_app),
                    title: Text(LocalizationKeys.app_logout.tr),
                  ),
                ),
              ),
            ],
          ).marginOnly(bottom: 16),
        ),
      ),
    );
  }
}
