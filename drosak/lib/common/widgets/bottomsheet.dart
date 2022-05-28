import 'package:drosak/common/viewmodel/filter_viewmodel.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showListBottomSheet(
    {required List<Icon> leadingIcons,
    required List<String> texts,
    required RxString selectedText}) {
  Get.bottomSheet(
    ListView.builder(
        itemCount: leadingIcons.length,
        itemBuilder: (context, index) {
          return Obx(() => ListTile(
                leading: leadingIcons[index],
                title: Text(texts[index]),
                selected: selectedText.value == texts[index],
                onTap: () {
                  selectedText.value = texts[index];
                  Get.back();
                },
              ));
        }),
    backgroundColor: Colors.white,
  );
}

showFilterBottomSheet(FilterViewModel filterViewModel) {
  Get.bottomSheet(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          LocalizationKeys.choose_education.tr,
          textAlign: TextAlign.start,
        ).marginSymmetric(horizontal: 16),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilterChip(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  label: Text(
                    LocalizationKeys.education_secondary.tr,
                    style: filterViewModel.selectEducationSecondary.value
                        ? TextStyle(color: Colors.white)
                        : TextStyle(color: Colors.black),
                  ),
                  avatar: Icon(Icons.school),
                  selected: filterViewModel.selectEducationSecondary.value,
                  showCheckmark: false,
                  backgroundColor: Colors.transparent,
                  elevation: 2,
                  pressElevation: 6,
                  shape: StadiumBorder(side: BorderSide()),
                  avatarBorder:
                      CircleBorder(side: BorderSide(color: Colors.grey)),
                  onSelected: (bool selected) {
                    filterViewModel.selectEducationSecondary.value = selected;
                  },
                  selectedColor: Colors.blue,
                ).marginSymmetric(horizontal: 16),
                FilterChip(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  label: Text(
                    LocalizationKeys.education_prep.tr,
                    style: filterViewModel.selectEducationPrep.value
                        ? TextStyle(color: Colors.white)
                        : TextStyle(color: Colors.black),
                  ),
                  avatar: Icon(Icons.school),
                  selected: filterViewModel.selectEducationPrep.value,
                  showCheckmark: false,
                  backgroundColor: Colors.transparent,
                  elevation: 2,
                  pressElevation: 6,
                  shape: StadiumBorder(side: BorderSide()),
                  avatarBorder:
                      CircleBorder(side: BorderSide(color: Colors.grey)),
                  onSelected: (bool selected) {
                    filterViewModel.selectEducationPrep.value = selected;
                  },
                  selectedColor: Colors.blue,
                ).marginSymmetric(horizontal: 16),
              ],
            ).marginSymmetric(horizontal: 16)),
        SizedBox(
          height: 20,
        ),
        Text(
          LocalizationKeys.choose_material.tr,
          textAlign: TextAlign.start,
        ).marginSymmetric(horizontal: 16),
        SizedBox(
          height: 50,
          child: ListView.builder(
              itemBuilder: (context, index) {
                return Obx(() => FilterChip(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      label: Text(
                        filterViewModel.materials[index].value.name.value,
                        style: filterViewModel
                                .materials[index].value.isSelected.isTrue
                            ? TextStyle(color: Colors.white)
                            : TextStyle(color: Colors.black),
                      ),
                      avatar: Icon(Icons.school),
                      selected: filterViewModel
                          .materials[index].value.isSelected.value,
                      showCheckmark: false,
                      backgroundColor: Colors.transparent,
                      elevation: 2,
                      pressElevation: 6,
                      shape: StadiumBorder(side: BorderSide()),
                      avatarBorder:
                          CircleBorder(side: BorderSide(color: Colors.grey)),
                      onSelected: (bool selected) {
                        filterViewModel
                            .materials[index].value.isSelected.value = selected;
                      },
                      selectedColor: Colors.blue,
                    ).marginSymmetric(horizontal: 16));
              },
              itemCount: filterViewModel.materials.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          LocalizationKeys.price_avg.tr,
          textAlign: TextAlign.start,
        ).marginSymmetric(horizontal: 16),
        Obx(() => Slider(
            value: filterViewModel.sliderValue.value,
            min: 0,
            max: 100,
            inactiveColor: Colors.blue,
            activeColor: Colors.purple,
            thumbColor: Colors.deepPurple,
            onChanged: (value) {
              filterViewModel.sliderValue.value = value;
            })),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  textStyle: TextStyle(color: Colors.white),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                // filterViewModel.applyFilter();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(LocalizationKeys.filter_apply.tr),
              ),
            ).marginSymmetric(horizontal: 16),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  side: BorderSide(color: Colors.blue, width: 1),
                  // textStyle: TextStyle(color: Colors.blue),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                // filterViewModel.applyFilter();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(LocalizationKeys.filter_clear_all.tr,
                    style: TextStyle(color: Colors.blue)),
              ),
            ).marginSymmetric(horizontal: 16),
          ],
        ),
        //todo: add government and area filter
      ],
    ),
    backgroundColor: Colors.white,
  );
}
