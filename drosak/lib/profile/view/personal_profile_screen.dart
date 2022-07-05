import 'package:drosak/common/widgets/bottomsheet.dart';
import 'package:drosak/common/widgets/fullwidth_textfield.dart';
import 'package:drosak/profile/viewmodel/profile_view_model.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PersonalProfileScreen extends StatelessWidget {
  PersonalProfileScreen({Key? key}) : super(key: key);

  final ProfileViewModel _profileViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(children: [
          SvgPicture.asset(
            AssetsManager.appbarBackGround,
          ),
          Container(
            child: Text(
              LocalizationKeys.personal_info.tr,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
        ),
      ),
      body: SingleChildScrollView(
          child: Obx(
        () => Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(height: 50),
          Hero(
            tag: 'profile_image_tag',
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => openGalleryOrCameraSelectorSheet(),
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Card(
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
                    const Positioned(
                      child: const CircleAvatar(
                        child: Icon(Icons.add, size: 20, color: Colors.white),
                        radius: 20,
                        backgroundColor: Colors.green,
                      ),
                      bottom: -20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Text('اضف صورة'),
          const SizedBox(height: 20),
          TextField(
              controller: _profileViewModel.nameController.value,
              decoration: InputDecoration(
                  labelText: 'الاسم الكامل',
                  hintText: 'الاسم الكامل ثلاثى',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue)))),
          const SizedBox(height: 20),
          TextField(
              controller: _profileViewModel.phoneController.value,
              decoration: InputDecoration(
                  labelText: LocalizationKeys.phone_number.tr,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue)))),
          const SizedBox(height: 20),
          TextField(
              controller: _profileViewModel.emailController.value,
              decoration: InputDecoration(
                  labelText: LocalizationKeys.email.tr,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue)))),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocalizationKeys.choose_government.tr),
                const SizedBox(height: 8),
                Container(
                  //choose government
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue)),
                  child: InkWell(
                    onTap: () {
                      showListBottomSheet(
                          leadingIcons: [
                            const Icon(Icons.location_city,
                                color: Colors.blue, size: 20),
                            const Icon(Icons.location_city,
                                color: Colors.blue, size: 20)
                          ],
                          texts: [
                            LocalizationKeys.government_cairo.tr,
                            LocalizationKeys.government_giza.tr
                          ],
                          selectedText:
                              _profileViewModel.selectedGovernmentName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:
                          Text(_profileViewModel.selectedGovernmentName.value),
                    ),
                  ),
                ),
              ],
            )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(LocalizationKeys.choose_area.tr),
                  margin: const EdgeInsets.only(right: 16),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue)),
                  child: InkWell(
                    onTap: () {
                      showListBottomSheet(leadingIcons: [
                        const Icon(Icons.location_city,
                            color: Colors.blue, size: 20),
                        const Icon(Icons.location_city,
                            color: Colors.blue, size: 20)
                      ], texts: [
                        LocalizationKeys.area_saft.tr,
                        LocalizationKeys.area_dokki.tr
                      ], selectedText: _profileViewModel.selectedAreaName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(_profileViewModel.selectedAreaName.value),
                    ),
                  ),
                ),
              ],
            )),
          ]),
          const SizedBox(height: 16),
          Align(
            child: Text(
              LocalizationKeys.choose_sex.tr,
            ),
            alignment: AlignmentDirectional.centerStart,
          ),
          const SizedBox(height: 8),
          FullWidthTextField(
              leadingIcons: [const Icon(Icons.male), const Icon(Icons.female)],
              texts: [LocalizationKeys.male.tr, LocalizationKeys.female.tr],
              selectedText: _profileViewModel.selectedGender),
          const SizedBox(height: 16),
          Align(
            //choose education
            child: Text(
              LocalizationKeys.choose_education.tr,
            ),
            alignment: AlignmentDirectional.centerStart,
          ),
          const SizedBox(height: 8),
          FullWidthTextField(leadingIcons: [
            const Icon(Icons.school),
            const Icon(Icons.school)
          ], texts: [
            LocalizationKeys.education_secondary.tr,
            LocalizationKeys.education_prep.tr
          ], selectedText: _profileViewModel.selectedEducation),
          const SizedBox(height: 16),
          Align(
            //choose education
            child: Text(
              LocalizationKeys.choose_class.tr,
            ),
            alignment: AlignmentDirectional.centerStart,
          ),
          const SizedBox(height: 8),
          FullWidthTextField(leadingIcons: [
            const Icon(Icons.class_),
            const Icon(Icons.class_),
            const Icon(Icons.class_)
          ], texts: [
            LocalizationKeys.class_level_one.tr,
            LocalizationKeys.class_level_two.tr,
            LocalizationKeys.class_level_three.tr,
          ], selectedText: _profileViewModel.selectedClass),
          const SizedBox(height: 32),
          ElevatedButton(
              onPressed: () {
                _profileViewModel.updateProfile();
              },
              style: ElevatedButton.styleFrom(
                onPrimary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  LocalizationKeys.save.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              )),
          const SizedBox(height: 32),
        ]).marginSymmetric(horizontal: 16),
      )),
    );
  }

  openGalleryOrCameraSelectorSheet() {}
}
