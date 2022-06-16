import 'package:drosak/common/model/filter_models.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:get/get.dart';

class FilterViewModel extends GetxController {
  RxBool selectEducationSecondary = false.obs;
  RxBool selectEducationPrep = false.obs;

  RxDouble sliderStartValue = 20.0.obs;
  RxDouble sliderEndValue = 90.0.obs;

  var materials = [
    FilterChipModel(name: LocalizationKeys.arabic.tr.obs, isSelected: false.obs)
        .obs,
    FilterChipModel(name: LocalizationKeys.math.tr.obs, isSelected: false.obs)
        .obs,
    FilterChipModel(
            name: LocalizationKeys.science.tr.obs, isSelected: false.obs)
        .obs,
    FilterChipModel(
            name: LocalizationKeys.biology.tr.obs, isSelected: false.obs)
        .obs,
    FilterChipModel(
            name: LocalizationKeys.chemistry.tr.obs, isSelected: false.obs)
        .obs,
    FilterChipModel(name: LocalizationKeys.social.tr.obs, isSelected: false.obs)
        .obs,
    FilterChipModel(
            name: LocalizationKeys.physics.tr.obs, isSelected: false.obs)
        .obs,
    FilterChipModel(
            name: LocalizationKeys.geography.tr.obs, isSelected: false.obs)
        .obs,
    FilterChipModel(
            name: LocalizationKeys.history.tr.obs, isSelected: false.obs)
        .obs,
    FilterChipModel(name: LocalizationKeys.french.tr.obs, isSelected: false.obs)
        .obs,
    FilterChipModel(name: LocalizationKeys.german.tr.obs, isSelected: false.obs)
        .obs,
    FilterChipModel(
            name: LocalizationKeys.spanish.tr.obs, isSelected: false.obs)
        .obs,
    FilterChipModel(
            name: LocalizationKeys.english.tr.obs, isSelected: false.obs)
        .obs,
  ];

  void applyFilter() {}

  void resetFilters() {
    selectEducationSecondary.value = false;
    selectEducationPrep.value = false;

    sliderStartValue.value = 20.0;
    sliderEndValue.value = 90.0;

    for (var filterModel in materials) {
      filterModel.value.isSelected.value = false;
    }
  }
}
