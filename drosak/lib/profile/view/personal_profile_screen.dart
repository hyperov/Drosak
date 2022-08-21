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
    return WillPopScope(
      onWillPop: () {
        _profileViewModel.readStudentProfileDataFromStorage();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Stack(children: [
            SvgPicture.asset(
              AssetsManager.appbarBackGround,
            ),
            Container(
              child: Text(
                LocalizationKeys.personal_info.tr,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: AssetsManager.fontFamily),
              ),
              alignment: AlignmentDirectional.centerStart,
            ),
          ], alignment: Alignment.center),
          toolbarHeight: 100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 25),
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
                                  .selectedProfileImageUrl.isEmpty
                              ? Image.asset(
                                  AssetsManager.student_empty_profile,
                                  width: 100,
                                  height: 100,
                                )
                              : Image.network(
                                  _profileViewModel
                                      .selectedProfileImageUrl.value,
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
                      const Positioned(
                        child: CircleAvatar(
                          child: Icon(Icons.add, size: 25, color: Colors.white),
                          radius: 20,
                          backgroundColor: Colors.deepPurpleAccent,
                        ),
                        bottom: -20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text('اضف صورة',
                style: TextStyle(fontWeight: FontWeight.w100, fontSize: 18)),
            const SizedBox(height: 20),
            Obx(() => TextField(
                maxLength: 70,
                controller: _profileViewModel.nameController.value,
                onChanged: (value) =>
                    _profileViewModel.errMessageNameTextField.value = null,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.name,
                // style: const TextStyle(fontStyle: FontStyle.normal),
                decoration: InputDecoration(
                    labelText: LocalizationKeys.full_name.tr,
                    hintText: LocalizationKeys.full_name.tr,
                    errorText: _profileViewModel.errMessageNameTextField.value,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(color: Colors.blue))))),
            const SizedBox(height: 20),
            Obx(() => TextField(
                controller: _profileViewModel.phoneController.value,
                onChanged: (value) =>
                    _profileViewModel.errMessagePhoneTextField.value = null,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: LocalizationKeys.phone_number.tr,
                    hintText: '011xxxxxxxx',
                    errorText: _profileViewModel.errMessagePhoneTextField.value,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(color: Colors.blue))))),
            const SizedBox(height: 20),
            Obx(() => TextField(
                controller: _profileViewModel.emailController.value,
                onChanged: (value) =>
                    _profileViewModel.errMessageEmailTextField.value = null,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: LocalizationKeys.email.tr,
                    hintText: 'ali@gmail.com',
                    errorText: _profileViewModel.errMessageEmailTextField.value,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(color: Colors.blue))))),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LocalizationKeys.choose_government.tr),
                  const SizedBox(height: 8),
                  FullWidthTextField(
                      leadingIcons: List.generate(
                          _profileViewModel.governments.length,
                          (index) => const Icon(
                                Icons.location_city,
                                color: Colors.deepPurpleAccent,
                              )),
                      texts: _profileViewModel.governments,
                      selectedText: _profileViewModel.selectedGovernmentName),
                ],
              )),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LocalizationKeys.choose_area.tr),
                  const SizedBox(height: 8),
                  Obx(() => FullWidthTextField(
                      leadingIcons: List.generate(
                          _profileViewModel.selectedGovernmentName.value ==
                                  _profileViewModel.governments[0]
                              ? _profileViewModel.areasCairo.length
                              : _profileViewModel.areasGiza.length,
                          (index) => const Icon(
                                Icons.location_city,
                                color: Colors.deepPurpleAccent,
                              )),
                      texts: _profileViewModel.selectedGovernmentName.value ==
                              _profileViewModel.governments[0]
                          ? _profileViewModel.areasCairo
                          : _profileViewModel.areasGiza,
                      selectedText: _profileViewModel.selectedAreaName)),
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
                leadingIcons: const [Icon(Icons.male), Icon(Icons.female)],
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
            FullWidthTextField(leadingIcons: const [
              Icon(Icons.school),
              Icon(Icons.school)
            ], texts: [
              LocalizationKeys.education_secondary.tr,
              LocalizationKeys.education_prep.tr
            ], selectedText: _profileViewModel.selectedEducationText),
            const SizedBox(height: 16),
            Align(
              //choose education
              child: Text(
                LocalizationKeys.choose_class.tr,
              ),
              alignment: AlignmentDirectional.centerStart,
            ),
            const SizedBox(height: 8),
            Obx(() => FullWidthTextField(
                    leadingIcons: const [
                      Icon(Icons.class_),
                      Icon(Icons.class_),
                      Icon(Icons.class_)
                    ],
                    texts: _profileViewModel.selectedEducationText.value ==
                            LocalizationKeys.education_secondary.tr
                        ? [
                            LocalizationKeys.secondary_class_level_one.tr,
                            LocalizationKeys.secondary_class_level_two.tr,
                            LocalizationKeys.secondary_class_level_three.tr,
                          ]
                        : [
                            LocalizationKeys.prep_class_level_one.tr,
                            LocalizationKeys.prep_class_level_two.tr,
                            LocalizationKeys.prep_class_level_three.tr,
                          ],
                    selectedText: _profileViewModel.selectedClassText)),
            const SizedBox(height: 32),
            ElevatedButton(
                onPressed: () {
                  if (_profileViewModel.validateProfile() == null) {
                    _profileViewModel.updateProfile();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    LocalizationKeys.save.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: AssetsManager.fontFamily,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                )),
            const SizedBox(height: 32),
          ]).marginSymmetric(horizontal: 16),
        ),
      ),
    );
  }

  void openGalleryOrCameraSelectorSheet() {
    showListBottomSheet(
        leadingIcons: _profileViewModel.galleryPickerSheetLeadingIcons,
        texts: _profileViewModel.galleryPickerSheetLeadingLeadingTexts,
        selectedText: _profileViewModel.selectedGalleryPickerSheetText,
        onTapAction: () => _profileViewModel.pickImage());
  }
}
