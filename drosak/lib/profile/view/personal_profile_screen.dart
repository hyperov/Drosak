import 'package:drosak/common/widgets/bottomsheet.dart';
import 'package:drosak/common/widgets/fullwidth_textfield.dart';
import 'package:drosak/profile/viewmodel/profile_view_model.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalProfileScreen extends StatelessWidget {
  PersonalProfileScreen({Key? key}) : super(key: key);

  final ProfileViewModel _profileViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Profile'),
      ),
      body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: const [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.person, size: 50),
                            radius: 50,
                          ),
                          Positioned(
                            child: CircleAvatar(
                              child: Icon(Icons.add,
                                  size: 20, color: Colors.white),
                              radius: 20,
                              backgroundColor: Colors.green,
                            ),
                            bottom: -20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text('Ahmed Ali'),
                      const SizedBox(height: 20),
                      Row(children: [
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.only(left: 16),
                          child: TextField(
                              decoration: InputDecoration(
                                  labelText: 'الاسم الأول',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.blue)))),
                        )),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.only(right: 16),
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: 'الاسم الأخير',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                          ),
                        )),
                      ]),
                      const SizedBox(height: 20),
                      Row(children: [
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocalizationKeys.choose_government.tr),
                            SizedBox(height: 8),
                            Container(
                              //choose government
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.blue)),
                              child: InkWell(
                                onTap: () {
                                  showListBottomSheet(
                                      leadingIcons: [
                                        Icon(Icons.location_city,
                                            color: Colors.blue, size: 20),
                                        Icon(Icons.location_city,
                                            color: Colors.blue, size: 20)
                                      ],
                                      texts: [
                                        LocalizationKeys.government_cairo.tr,
                                        LocalizationKeys.government_giza.tr
                                      ],
                                      selectedText: _profileViewModel
                                          .selectedGovernmentName);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(_profileViewModel
                                      .selectedGovernmentName.value),
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
                              margin: EdgeInsets.only(right: 16),
                            ),
                            SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.blue)),
                              child: InkWell(
                                onTap: () {
                                  showListBottomSheet(
                                      leadingIcons: [
                                        Icon(Icons.location_city,
                                            color: Colors.blue, size: 20),
                                        Icon(Icons.location_city,
                                            color: Colors.blue, size: 20)
                                      ],
                                      texts: [
                                        LocalizationKeys.area_saft.tr,
                                        LocalizationKeys.area_dokki.tr
                                      ],
                                      selectedText:
                                          _profileViewModel.selectedAreaName);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                      _profileViewModel.selectedAreaName.value),
                                ),
                              ),
                            ),
                          ],
                        )),
                      ]),
                      SizedBox(height: 16),
                      Align(
                        child: Text(
                          LocalizationKeys.choose_sex.tr,
                        ),
                        alignment: AlignmentDirectional.centerStart,
                      ),
                      SizedBox(height: 8),
                      FullWidthTextField(leadingIcons: [
                        const Icon(Icons.male),
                        const Icon(Icons.female)
                      ], texts: [
                        LocalizationKeys.male.tr,
                        LocalizationKeys.female.tr
                      ], selectedText: _profileViewModel.selectedType),
                      SizedBox(height: 16),
                      Align(
                        //choose education
                        child: Text(
                          LocalizationKeys.choose_education.tr,
                        ),
                        alignment: AlignmentDirectional.centerStart,
                      ),
                      SizedBox(height: 8),
                      FullWidthTextField(leadingIcons: [
                        const Icon(Icons.school),
                        const Icon(Icons.school)
                      ], texts: [
                        LocalizationKeys.education_secondary.tr,
                        LocalizationKeys.education_prep.tr
                      ], selectedText: _profileViewModel.selectedEducation),
                      SizedBox(height: 16),
                      Align(
                        //choose education
                        child: Text(
                          LocalizationKeys.choose_class.tr,
                        ),
                        alignment: AlignmentDirectional.centerStart,
                      ),
                      SizedBox(height: 8),
                      FullWidthTextField(leadingIcons: [
                        const Icon(Icons.class_),
                        const Icon(Icons.class_),
                        const Icon(Icons.class_)
                      ], texts: [
                        LocalizationKeys.class_level_one.tr,
                        LocalizationKeys.class_level_two.tr,
                        LocalizationKeys.class_level_three.tr,
                      ], selectedText: _profileViewModel.selectedClass),
                      SizedBox(height: 32),
                      ElevatedButton(
                          onPressed: () {
                            _profileViewModel.updateProfile();
                          },
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.blue,
                          ),
                          child: Text(
                            LocalizationKeys.save.tr,
                            style: TextStyle(color: Colors.white),
                          )),
                      SizedBox(height: 32),
                    ]),
              ))),
    );
  }
}
