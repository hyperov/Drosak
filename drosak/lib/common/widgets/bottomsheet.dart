import 'package:drosak/bookings/viewmodel/booking_view_model.dart';
import 'package:drosak/common/viewmodel/filter_viewmodel.dart';
import 'package:drosak/lectures/viewmodel/lectures_viewmodel.dart';
import 'package:drosak/reviews/viewmodel/reviews_viewmodel.dart';
import 'package:drosak/teachers/model/teacher.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
                  title: Text(
                    texts[index],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  selected: selectedText.value == texts[index],
                  selectedTileColor: ColorManager.redOrangeLight,
                  selectedColor: ColorManager.lightPurple,
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

showFilterBottomSheet(BuildContext context, FilterViewModel filterViewModel) {
  Get.bottomSheet(
    DraggableScrollableSheet(
      initialChildSize: 0.8,
      //set this as you want
      maxChildSize: 0.9,
      //set this as you want
      minChildSize: 0.6,
      //set this as you want
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                LocalizationKeys.choose_education.tr,
                textAlign: TextAlign.start,
              ).marginSymmetric(horizontal: 16),
              Theme(
                data: ThemeData(
                  fontFamily: 'Roboto',
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => FilterChip(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          label: Text(
                            LocalizationKeys.education_secondary.tr,
                            style:
                                filterViewModel.selectEducationSecondary.value
                                    ? const TextStyle(color: Colors.white)
                                    : const TextStyle(color: Colors.black),
                          ),
                          avatar: Icon(Icons.school,
                              color:
                                  filterViewModel.selectEducationSecondary.value
                                      ? Colors.white
                                      : ColorManager.blueLight),
                          selected:
                              filterViewModel.selectEducationSecondary.value,
                          showCheckmark: false,
                          backgroundColor: Colors.transparent,
                          elevation: 2,
                          pressElevation: 6,
                          shape: const StadiumBorder(side: BorderSide()),
                          avatarBorder: const CircleBorder(
                              side: BorderSide(color: Colors.grey)),
                          onSelected: (bool selected) {
                            filterViewModel.isFilterApplied = true;
                            filterViewModel.selectEducationSecondary.value =
                                selected;
                          },
                          selectedColor: ColorManager.deepPurple,
                        ).marginSymmetric(horizontal: 16)),
                    Obx(() => FilterChip(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          label: Text(
                            LocalizationKeys.education_prep.tr,
                            style: filterViewModel.selectEducationPrep.value
                                ? const TextStyle(color: Colors.white)
                                : const TextStyle(color: Colors.black),
                          ),
                          avatar: Icon(Icons.school,
                              color: filterViewModel.selectEducationPrep.value
                                  ? Colors.white
                                  : ColorManager.blueLight),
                          selected: filterViewModel.selectEducationPrep.value,
                          showCheckmark: false,
                          backgroundColor: Colors.transparent,
                          elevation: 2,
                          pressElevation: 6,
                          shape: const StadiumBorder(side: BorderSide()),
                          avatarBorder: const CircleBorder(
                              side: BorderSide(color: Colors.grey)),
                          onSelected: (bool selected) {
                            filterViewModel.isFilterApplied = true;
                            filterViewModel.selectEducationPrep.value =
                                selected;
                          },
                          selectedColor: ColorManager.deepPurple,
                        ).marginSymmetric(horizontal: 16)),
                  ],
                ).marginSymmetric(horizontal: 16),
              ),
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
                            avatar: Icon(Icons.school,
                                color: filterViewModel
                                        .materials[index].value.isSelected.value
                                    ? Colors.white
                                    : ColorManager.blueLight),
                            selected: filterViewModel
                                .materials[index].value.isSelected.value,
                            showCheckmark: false,
                            backgroundColor: Colors.transparent,
                            elevation: 2,
                            pressElevation: 6,
                            shape: const StadiumBorder(side: BorderSide()),
                            avatarBorder: const CircleBorder(
                                side: BorderSide(color: Colors.grey)),
                            onSelected: (bool selected) {
                              filterViewModel.isFilterApplied = true;
                              filterViewModel.materials[index].value.isSelected
                                  .value = selected;
                            },
                            selectedColor: ColorManager.deepPurple,
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
                LocalizationKeys.choose_government.tr,
                textAlign: TextAlign.start,
              ).marginSymmetric(horizontal: 16),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: RadioListTile(
                          // cairo
                          title: Text(LocalizationKeys.government_cairo.tr),
                          value: LocalizationKeys.government_cairo.tr,
                          groupValue: filterViewModel.governmentVal.value,
                          selected: filterViewModel.selectGovernmentCairo.value,
                          selectedTileColor: ColorManager.redOrangeDark,
                          activeColor: ColorManager.blueDark,
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          onChanged: (value) {
                            filterViewModel.governmentVal.value =
                                value.toString();
                            if (filterViewModel.governmentVal.value ==
                                LocalizationKeys.government_cairo.tr) {
                              filterViewModel.selectGovernmentCairo.value =
                                  true;
                              filterViewModel.selectGovernmentGiza.value =
                                  false;
                            }
                          }),
                    ),
                    Expanded(
                      child: RadioListTile(
                          // giza
                          title: Text(LocalizationKeys.government_giza.tr),
                          value: LocalizationKeys.government_giza.tr,
                          groupValue: filterViewModel.governmentVal.value,
                          selected: filterViewModel.selectGovernmentGiza.value,
                          selectedTileColor: ColorManager.redOrangeDark,
                          activeColor: ColorManager.blueDark,
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          onChanged: (value) {
                            filterViewModel.governmentVal.value =
                                value.toString();
                            if (filterViewModel.governmentVal.value ==
                                LocalizationKeys.government_giza.tr) {
                              filterViewModel.selectGovernmentGiza.value = true;
                              filterViewModel.selectGovernmentCairo.value =
                                  false;
                            }
                          }),
                    )
                  ],
                ),
              ),
              Text(
                LocalizationKeys.choose_area.tr,
                textAlign: TextAlign.start,
              ).marginSymmetric(horizontal: 16),
              SizedBox(
                height: 50,
                child: Obx(() => ListView.builder(
                    itemBuilder: (context, index) {
                      return Obx(() => FilterChip(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            label: Text(
                              filterViewModel.selectGovernmentCairo.value
                                  ? filterViewModel.areasCairoFilterChips[index]
                                      .value.name.value
                                  : filterViewModel.areasGizaFilterChips[index]
                                      .value.name.value,
                              style: filterViewModel.selectGovernmentCairo.value
                                  ? filterViewModel.areasCairoFilterChips[index]
                                          .value.isSelected.isTrue
                                      ? const TextStyle(color: Colors.white)
                                      : const TextStyle(color: Colors.black)
                                  : filterViewModel.areasGizaFilterChips[index]
                                          .value.isSelected.isTrue
                                      ? const TextStyle(color: Colors.white)
                                      : const TextStyle(color: Colors.black),
                            ),
                            avatar: filterViewModel.governmentVal.value ==
                                    LocalizationKeys.government_cairo.tr
                                ? Icon(Icons.school,
                                    color: filterViewModel
                                            .areasCairoFilterChips[index]
                                            .value
                                            .isSelected
                                            .value
                                        ? Colors.white
                                        : ColorManager.blueLight)
                                : Icon(Icons.school,
                                    color: filterViewModel
                                            .areasGizaFilterChips[index]
                                            .value
                                            .isSelected
                                            .value
                                        ? Colors.white
                                        : ColorManager.blueLight),
                            selected: filterViewModel.governmentVal.value ==
                                    LocalizationKeys.government_cairo.tr
                                ? filterViewModel.areasCairoFilterChips[index]
                                    .value.isSelected.value
                                : filterViewModel.areasGizaFilterChips[index]
                                    .value.isSelected.value,
                            showCheckmark: false,
                            backgroundColor: Colors.transparent,
                            elevation: 2,
                            pressElevation: 6,
                            shape: const StadiumBorder(side: BorderSide()),
                            avatarBorder: const CircleBorder(
                                side: BorderSide(color: Colors.grey)),
                            onSelected: (bool selected) {
                              filterViewModel.isFilterApplied = true;
                              if (filterViewModel.governmentVal.value ==
                                  LocalizationKeys.government_cairo.tr) {
                                filterViewModel.areasCairoFilterChips[index]
                                    .value.isSelected.value = selected;
                              } else {
                                filterViewModel.areasGizaFilterChips[index]
                                    .value.isSelected.value = selected;
                              }
                            },
                            selectedColor: ColorManager.deepPurple,
                          ).marginSymmetric(horizontal: 16));
                    },
                    itemCount: filterViewModel.governmentVal.value ==
                            LocalizationKeys.government_cairo.tr
                        ? filterViewModel.areasCairoFilterChips.length
                        : filterViewModel.areasGizaFilterChips.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true)),
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
                          max: 500,
                          inactiveColor: Colors.grey.shade600,
                          activeColor: Colors.purple,
                          divisions: 50,
                          values: RangeValues(
                              filterViewModel.sliderStartValue.value,
                              filterViewModel.sliderEndValue.value),
                          labels: RangeLabels(
                              filterViewModel.sliderStartValue.value.toString(),
                              filterViewModel.sliderEndValue.value.toString()),
                          onChanged: (RangeValues values) {
                            filterViewModel.isFilterApplied = true;
                            filterViewModel.sliderStartValue.value =
                                values.start;
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
                        primary: ColorManager.deepPurple,
                        textStyle: const TextStyle(color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: () async {
                      filterViewModel.isFilterAppliedConfirmed = true;
                      await filterViewModel.applyFilter();
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(LocalizationKeys.filter_apply.tr),
                    ),
                  ).marginSymmetric(horizontal: 16),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      side: const BorderSide(
                          color: ColorManager.deepPurple, width: 1),
                      // textStyle: TextStyle(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () async {
                      await filterViewModel.resetFilters();
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(LocalizationKeys.filter_clear_all.tr,
                          style:
                              const TextStyle(color: ColorManager.deepPurple)),
                    ),
                  ).marginSymmetric(horizontal: 16),
                ],
              ).marginOnly(bottom: 32),
            ],
          ),
        );
      },
    ),
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16))),
  ).whenComplete(() => {
        if (!Get.isBottomSheetOpen! &&
            filterViewModel.isFilterApplied &&
            !filterViewModel.isFilterAppliedConfirmed)
          {filterViewModel.resetFilters()}
      });
}

showConfirmBookingBottomSheet(
    BuildContext context,
    LecturesViewModel lecturesViewModel,
    BookingsViewModel bookingsViewModel,
    int index,
    Teacher teacher,
    PanelController slidingUpPanelController) {
  Get.bottomSheet(
    SingleChildScrollView(
      child: Card(
        elevation: 0,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                width: 40,
                height: 4,
                color: Colors.grey,
              ),
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
                      child: Image.network(
                          lecturesViewModel.lectures[index].teacherImageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                        return SvgPicture.asset(
                          AssetsManager.profilePlaceHolder,
                          width: 60,
                          height: 60,
                          color: Colors.white,
                          fit: BoxFit.cover,
                        ).marginAll(16);
                      })),
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
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
              Text(lecturesViewModel.lectures[index].teacherName,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              const SizedBox(height: 4),
              Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  color: Colors.white,
                  child: const Icon(
                    Icons.school,
                    color: ColorManager.blueDark,
                    size: 32,
                  ).marginAll(14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              Text(lecturesViewModel.lectures[index].centerName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(lecturesViewModel.lectures[index].classLevel,
                      style: const TextStyle(
                        fontSize: 15,
                      )),
                  const Text(' / '),
                  Text(lecturesViewModel.lectures[index].material,
                      style: const TextStyle(
                        fontSize: 15,
                      )),
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
              Text(lecturesViewModel.lectures[index].address),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(
                  children: [
                    SvgPicture.asset(AssetsManager.calendar),
                    Text(lecturesViewModel.lectures[index].day,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                Container(
                  height: 1,
                  width: 60,
                  color: Colors.black,
                ),
                Column(
                  children: [
                    SvgPicture.asset(AssetsManager.clock),
                    Text(lecturesViewModel.lectures[index].time,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                Container(
                  height: 1,
                  width: 60,
                  color: Colors.black,
                ),
                Column(
                  children: [
                    SvgPicture.asset(AssetsManager.money),
                    Text(
                        "${lecturesViewModel.lectures[index].price.toString()}ج ",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                )
              ]),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 48,
                margin: const EdgeInsets.symmetric(horizontal: 32),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      EasyLoading.show(status: "جاري حجز المحاضرة");
                      await bookingsViewModel
                          .bookLecture(lecturesViewModel.lectures[index]);
                      Get.back();
                      Get.back();
                      slidingUpPanelController.close();
                    } catch (e) {
                      print(e.toString());
                      EasyLoading.showError(e.toString());
                    }
                  },
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
              const SizedBox(
                height: 16,
              ),
            ]),
      ),
    ),
    backgroundColor: Colors.white,
    clipBehavior: Clip.hardEdge,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(32),
      ),
    ),
  );
}

showRatingTeacherBottomSheet(
    BuildContext context, ReviewsViewModel reviewsViewModel, Teacher teacher) {
  Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 45,
                height: 3,
                color: Colors.grey,
                margin: const EdgeInsets.symmetric(vertical: 8),
              ),
              const SizedBox(height: 32),
              Text(
                LocalizationKeys.rate_teacher.tr,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 16),
              RatingBar.builder(
                initialRating: 5,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                unratedColor: Colors.grey,
                itemSize: 40,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (double value) {
                  reviewsViewModel.rating = value;
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                // height: 200,
                child: TextField(
                  controller: reviewsViewModel.addedReviewTextController,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.text,
                  textAlignVertical: TextAlignVertical.top,
                  style: const TextStyle(decoration: TextDecoration.none),
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorManager.redOrangeLight,
                    hintText: LocalizationKeys.review_text_hint.tr,
                    hintStyle: const TextStyle(color: Colors.grey),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: ColorManager.deepPurple, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: ColorManager.deepPurple, width: 1)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 48,
                margin: const EdgeInsets.only(bottom: 24),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      EasyLoading.show(status: "جاري تقييم المدرس");
                      await reviewsViewModel.reviewTeacher(teacher);
                      EasyLoading.dismiss();
                      Get.back();
                      EasyLoading.showSuccess(LocalizationKeys.review_added.tr);
                    } catch (e) {
                      print(e.toString());
                      EasyLoading.showError(e.toString());
                    }
                  },
                  child: Text(LocalizationKeys.add_review.tr,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ).marginSymmetric(horizontal: 32),
        ),
      ),
      backgroundColor: Colors.white,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(32),
      )));
}
