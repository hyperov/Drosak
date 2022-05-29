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
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          LocalizationKeys.choose_education.tr,
          textAlign: TextAlign.start,
        ).marginSymmetric(horizontal: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => FilterChip(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  label: Text(
                    LocalizationKeys.education_secondary.tr,
                    style: filterViewModel.selectEducationSecondary.value
                        ? const TextStyle(color: Colors.white)
                        : const TextStyle(color: Colors.black),
                  ),
                  avatar: const Icon(Icons.school),
                  selected: filterViewModel.selectEducationSecondary.value,
                  showCheckmark: false,
                  backgroundColor: Colors.transparent,
                  elevation: 2,
                  pressElevation: 6,
                  shape: const StadiumBorder(side: const BorderSide()),
                  avatarBorder:
                      const CircleBorder(side: BorderSide(color: Colors.grey)),
                  onSelected: (bool selected) {
                    filterViewModel.selectEducationSecondary.value = selected;
                  },
                  selectedColor: Colors.blue,
                ).marginSymmetric(horizontal: 16)),
            Obx(() => FilterChip(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  label: Text(
                    LocalizationKeys.education_prep.tr,
                    style: filterViewModel.selectEducationPrep.value
                        ? const TextStyle(color: Colors.white)
                        : const TextStyle(color: Colors.black),
                  ),
                  avatar: const Icon(Icons.school),
                  selected: filterViewModel.selectEducationPrep.value,
                  showCheckmark: false,
                  backgroundColor: Colors.transparent,
                  elevation: 2,
                  pressElevation: 6,
                  shape: const StadiumBorder(side: const BorderSide()),
                  avatarBorder: const CircleBorder(
                      side: const BorderSide(color: Colors.grey)),
                  onSelected: (bool selected) {
                    filterViewModel.selectEducationPrep.value = selected;
                  },
                  selectedColor: Colors.blue,
                ).marginSymmetric(horizontal: 16)),
          ],
        ).marginSymmetric(horizontal: 16),
        const SizedBox(
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
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      label: Text(
                        filterViewModel.materials[index].value.name.value,
                        style: filterViewModel
                                .materials[index].value.isSelected.isTrue
                            ? const TextStyle(color: Colors.white)
                            : const TextStyle(color: Colors.black),
                      ),
                      avatar: const Icon(Icons.school),
                      selected: filterViewModel
                          .materials[index].value.isSelected.value,
                      showCheckmark: false,
                      backgroundColor: Colors.transparent,
                      elevation: 2,
                      pressElevation: 6,
                      shape: const StadiumBorder(side: const BorderSide()),
                      avatarBorder: const CircleBorder(
                          side: const BorderSide(color: Colors.grey)),
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
        const SizedBox(
          height: 20,
        ),
        Text(
          LocalizationKeys.price_avg.tr,
          textAlign: TextAlign.start,
        ).marginSymmetric(horizontal: 16),
        Obx(() => Stack(
              children: [
                PositionedDirectional(
                    child: Text(filterViewModel.sliderStartValue.value
                        .toInt()
                        .toString()),
                    bottom: 40,
                    start: 24),
                PositionedDirectional(
                    child: Text(filterViewModel.sliderEndValue.value
                        .toInt()
                        .toString()),
                    bottom: 40,
                    end: 24),
                RangeSlider(
                    min: 0,
                    max: 100,
                    inactiveColor: Colors.blue,
                    activeColor: Colors.purple,
                    divisions: 20,
                    values: RangeValues(filterViewModel.sliderStartValue.value,
                        filterViewModel.sliderEndValue.value),
                    labels: RangeLabels(
                        filterViewModel.sliderStartValue.value.toString(),
                        filterViewModel.sliderEndValue.value.toString()),
                    onChanged: (RangeValues values) {
                      filterViewModel.sliderStartValue.value = values.start;
                      filterViewModel.sliderEndValue.value = values.end;
                    }).marginSymmetric(horizontal: 16).marginOnly(top: 40)
              ],
            )),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  textStyle: const TextStyle(color: Colors.white),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                filterViewModel.applyFilter();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(LocalizationKeys.filter_apply.tr),
              ),
            ).marginSymmetric(horizontal: 16),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  side: const BorderSide(color: Colors.blue, width: 1),
                  // textStyle: TextStyle(color: Colors.blue),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                filterViewModel.resetFilters();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(LocalizationKeys.filter_clear_all.tr,
                    style: const TextStyle(color: Colors.blue)),
              ),
            ).marginSymmetric(horizontal: 16),
          ],
        ).marginOnly(bottom: 32),
        //todo: add government and area filter
      ],
    ),
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: const Radius.circular(16))),
  );
}
