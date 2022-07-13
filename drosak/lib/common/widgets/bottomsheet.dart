import 'package:drosak/common/viewmodel/filter_viewmodel.dart';
import 'package:drosak/lectures/viewmodel/lectures_viewmodel.dart';
import 'package:drosak/teachers/model/teacher.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

showListBottomSheet(
    {required List<Icon> leadingIcons,
    required List<String> texts,
    required RxString selectedText,
    Function()? onTapAction}) {
  Get.bottomSheet(
      ListView.builder(
          shrinkWrap: true,
          itemCount: leadingIcons.length,
          itemBuilder: (context, index) {
            return Obx(() => ListTile(
                  leading: leadingIcons[index],
                  title: Text(texts[index]),
                  selected: selectedText.value == texts[index],
                  onTap: () {
                    selectedText.value = texts[index];
                    FocusManager.instance.primaryFocus?.unfocus();
                    Get.back();
                    if (onTapAction != null) {
                      onTapAction();
                    }
                  },
                ));
          }),
      backgroundColor: Colors.white,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ));
}

showFilterBottomSheet(FilterViewModel filterViewModel) {
  Get.bottomSheet(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
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
                    borderRadius: BorderRadius.circular(8)),
              ),
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
            topLeft: Radius.circular(16), topRight: Radius.circular(16))),
  );
}

showConfirmBookingDialog(BuildContext context,
    LecturesViewModel lecturesViewModel, int index, Teacher teacher) {
  Get.bottomSheet(
    Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Card(
                    color: Colors.deepPurple,
                    elevation: 4,
                    clipBehavior: Clip.hardEdge,
                    shape: const CircleBorder(
                        side: BorderSide(
                            color: Colors.deepPurpleAccent, width: 1)),
                    child: Image.network(teacher.photoUrl!,
                        width: 80, height: 80, fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                      return SvgPicture.asset(
                        AssetsManager.profilePlaceHolder,
                        width: 70,
                        height: 70,
                        color: Colors.white,
                        fit: BoxFit.cover,
                      ).marginAll(16);
                    })),
                Positioned(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.deepPurpleAccent),
                      borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(16),
                          right: Radius.circular(16)),
                    ),
                    child: Row(children: [
                      SvgPicture.asset(
                        AssetsManager.star,
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(teacher.avgRating.toString(),
                          style: const TextStyle(
                              fontSize: 10, color: Colors.black)),
                    ]),
                  ),
                  bottom: -5,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(teacher.name!,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(height: 4),
            Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
                margin: const EdgeInsets.symmetric(horizontal: 100)),
            const SizedBox(height: 4),
            Card(
                elevation: 4,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                color: Colors.white,
                child: const Icon(Icons.school).marginAll(14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
            Text(lecturesViewModel.lectures[index].centerName),
            const SizedBox(height: 0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(lecturesViewModel.lectures[index].classLevel),
                const Text(' / '),
                Text(lecturesViewModel.lectures[index].material),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_pin),
                Text(lecturesViewModel.lectures[index].city),
                const Text(' - '),
                Text(lecturesViewModel.lectures[index].area),
              ],
            ),
            const SizedBox(height: 4),
            Text(lecturesViewModel.lectures[index].address),
            const SizedBox(height: 4),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Column(
                children: [
                  const Icon(Icons.calendar_today),
                  Text(lecturesViewModel.lectures[index].day),
                ],
              ),
              Container(
                height: 1,
                width: 60,
                color: Colors.black,
              ),
              Column(
                children: [
                  const Icon(Icons.punch_clock),
                  Text(lecturesViewModel.lectures[index].time),
                ],
              ),
              Container(
                height: 1,
                width: 60,
                color: Colors.black,
              ),
              Column(
                children: [
                  const Icon(Icons.money),
                  Text(
                      "${lecturesViewModel.lectures[index].price.toString()}ج "),
                ],
              )
            ]),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 48,
              margin: const EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(LocalizationKeys.confirm_booking.tr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ]),
    ),
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(32),
      ),
    ),
  );
}
