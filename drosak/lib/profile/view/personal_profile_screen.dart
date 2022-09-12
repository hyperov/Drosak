import 'package:drosak/common/model/filters.dart';
import 'package:drosak/common/widgets/bottomsheet.dart';
import 'package:drosak/common/widgets/fullwidth_textfield.dart';
import 'package:drosak/profile/viewmodel/profile_view_model.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../common/viewmodel/network_viewmodel.dart';

class PersonalProfileScreen extends StatelessWidget {
  PersonalProfileScreen({Key? key}) : super(key: key);

  final ProfileViewModel _profileViewModel = Get.find();
  final NetworkViewModel _networkViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    FirebaseCrashlytics.instance.log('PersonalProfileScreen');
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'firebase_screen': 'personal_profile_screen',
        'firebase_screen_class': 'PersonalProfileScreen',
      },
    );
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
          toolbarHeight: 40 * Get.pixelRatio,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Get.pixelRatio * 12),
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
                                        width: 42 * Get.pixelRatio,
                                        height: 42 * Get.pixelRatio,
                                      )
                                    : FadeInImage.assetNetwork(
                                        placeholder:
                                            AssetsManager.student_empty_profile,
                                        image: _profileViewModel
                                            .selectedProfileImageUrl.value,
                                        width: 42 * Get.pixelRatio,
                                        height: 42 * Get.pixelRatio,
                                        fit: BoxFit.cover,
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            AssetsManager.student_empty_profile,
                                            width: 42 * Get.pixelRatio,
                                            height: 42 * Get.pixelRatio,
                                          );
                                        },
                                      ))),
                            Positioned(
                              child: CircleAvatar(
                                child: Icon(Icons.add,
                                    size: 10 * Get.pixelRatio,
                                    color: Colors.white),
                                radius: 8 * Get.pixelRatio,
                                backgroundColor: Colors.deepPurpleAccent,
                              ),
                              bottom: -20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12 * Get.pixelRatio),
                  const Text('اضف صورة',
                      style:
                          TextStyle(fontWeight: FontWeight.w100, fontSize: 18)),
                  SizedBox(height: 10 * Get.pixelRatio),
                  Obx(() => TextField(
                      maxLength: 70,
                      controller: _profileViewModel.nameController.value,
                      onChanged: (value) => _profileViewModel
                          .errMessageNameTextField.value = null,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.name,
                      // style: const TextStyle(fontStyle: FontStyle.normal),
                      decoration: InputDecoration(
                          labelText: LocalizationKeys.full_name.tr,
                          hintText: LocalizationKeys.full_name.tr,
                          errorText:
                              _profileViewModel.errMessageNameTextField.value,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide:
                                  const BorderSide(color: Colors.blue))))),
                  SizedBox(height: 10 * Get.pixelRatio),
                  Obx(() => TextField(
                      controller: _profileViewModel.phoneController.value,
                      onChanged: (value) => _profileViewModel
                          .errMessagePhoneTextField.value = null,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: LocalizationKeys.phone_number.tr,
                          hintText: '01xxxxxxxxx',
                          errorText:
                              _profileViewModel.errMessagePhoneTextField.value,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide:
                                  const BorderSide(color: Colors.blue))))),
                  SizedBox(height: 10 * Get.pixelRatio),
                  Obx(() => TextField(
                      controller: _profileViewModel.emailController.value,
                      onChanged: (value) => _profileViewModel
                          .errMessageEmailTextField.value = null,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: LocalizationKeys.email.tr,
                          hintText: 'ali@gmail.com',
                          errorText:
                              _profileViewModel.errMessageEmailTextField.value,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide:
                                  const BorderSide(color: Colors.blue))))),
                  SizedBox(height: 8 * Get.pixelRatio),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocalizationKeys.choose_government.tr),
                            SizedBox(height: 4 * Get.pixelRatio),
                            FullWidthTextField(
                                leadingIcons: List.generate(
                                    Filters.governments.length,
                                    (index) => const Icon(
                                          Icons.location_city,
                                          color: Colors.deepPurpleAccent,
                                        )),
                                texts: Filters.governments,
                                selectedText:
                                    _profileViewModel.selectedGovernmentName),
                          ],
                        )),
                        SizedBox(width: 5 * Get.pixelRatio),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocalizationKeys.choose_area.tr),
                            SizedBox(height: 4 * Get.pixelRatio),
                            Obx(() => FullWidthTextField(
                                leadingIcons: List.generate(
                                    _profileViewModel
                                                .selectedGovernmentName.value ==
                                            Filters.governments[0]
                                        ? Filters.areasCairo.length
                                        : Filters.areasGiza.length,
                                    (index) => const Icon(
                                          Icons.location_city,
                                          color: Colors.deepPurpleAccent,
                                        )),
                                texts: _profileViewModel
                                            .selectedGovernmentName.value ==
                                        Filters.governments[0]
                                    ? Filters.areasCairo
                                    : Filters.areasGiza,
                                selectedText:
                                    _profileViewModel.selectedAreaName)),
                          ],
                        )),
                      ]),
                  SizedBox(height: 8 * Get.pixelRatio),
                  Align(
                    child: Text(
                      LocalizationKeys.choose_sex.tr,
                    ),
                    alignment: AlignmentDirectional.centerStart,
                  ),
                  SizedBox(height: 4 * Get.pixelRatio),
                  FullWidthTextField(leadingIcons: const [
                    Icon(Icons.male),
                    Icon(Icons.female)
                  ], texts: [
                    LocalizationKeys.male.tr,
                    LocalizationKeys.female.tr
                  ], selectedText: _profileViewModel.selectedGender),
                  SizedBox(height: 8 * Get.pixelRatio),
                  Align(
                    //choose education
                    child: Text(
                      LocalizationKeys.choose_education.tr,
                    ),
                    alignment: AlignmentDirectional.centerStart,
                  ),
                  SizedBox(height: 4 * Get.pixelRatio),
                  FullWidthTextField(leadingIcons: const [
                    Icon(Icons.school),
                    Icon(Icons.school)
                  ], texts: [
                    LocalizationKeys.education_secondary.tr,
                    LocalizationKeys.education_prep.tr
                  ], selectedText: _profileViewModel.selectedEducationText),
                  SizedBox(height: 8 * Get.pixelRatio),
                  Align(
                    //choose education
                    child: Text(
                      LocalizationKeys.choose_class.tr,
                    ),
                    alignment: AlignmentDirectional.centerStart,
                  ),
                  SizedBox(height: 4 * Get.pixelRatio),
                  Obx(() => FullWidthTextField(
                          leadingIcons: const [
                            Icon(Icons.class_),
                            Icon(Icons.class_),
                            Icon(Icons.class_)
                          ],
                          texts: _profileViewModel
                                      .selectedEducationText.value ==
                                  LocalizationKeys.education_secondary.tr
                              ? [
                                  LocalizationKeys.secondary_class_level_one.tr,
                                  LocalizationKeys.secondary_class_level_two.tr,
                                  LocalizationKeys
                                      .secondary_class_level_three.tr,
                                ]
                              : [
                                  LocalizationKeys.prep_class_level_one.tr,
                                  LocalizationKeys.prep_class_level_two.tr,
                                  LocalizationKeys.prep_class_level_three.tr,
                                ],
                          selectedText: _profileViewModel.selectedClassText)),
                  SizedBox(height: 12 * Get.pixelRatio),
                  ElevatedButton(
                      onPressed: () {
                        if (_profileViewModel.validateProfile() == null) {
                          FirebaseCrashlytics.instance
                              .log('update profile button pressed');
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
                        padding:
                            EdgeInsets.symmetric(vertical: 4 * Get.pixelRatio),
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
                  SizedBox(height: 14 * Get.pixelRatio),
                ]).marginSymmetric(horizontal: 6 * Get.pixelRatio),
          ),
        ),
      ),
    );
  }

  void openGalleryOrCameraSelectorSheet() {
    if (_networkViewModel.isConnected.value) {
      showListBottomSheet(
          leadingIcons: _profileViewModel.galleryPickerSheetLeadingIcons,
          texts: _profileViewModel.galleryPickerSheetLeadingLeadingTexts,
          selectedText: _profileViewModel.selectedGalleryPickerSheetText,
          onTapAction: () => _profileViewModel.pickImage());
    } else {
      _networkViewModel.showNoInternetConnectionDialog();
    }
  }
}
