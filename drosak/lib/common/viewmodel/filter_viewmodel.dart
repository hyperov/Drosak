import 'package:drosak/common/model/filter_models.dart';
import 'package:drosak/teachers/viewmodel/teachers_list_viewmodel.dart';
import 'package:drosak/utils/firestore_names.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:get/get.dart';

class FilterViewModel extends GetxController {
  final TeachersListViewModel _teachersListViewModel = Get.find();

  bool isFilterApplied = false;
  RxBool selectEducationSecondary = false.obs;
  RxBool selectEducationPrep = false.obs;

  static const double _minRating = 20.0;
  static const double _maxRating = 500.0;
  RxDouble sliderStartValue = _minRating.obs;
  RxDouble sliderEndValue = _maxRating.obs;

  RxList<String> selectedFilters = <String>[].obs;

  var materials = [
    FilterChipModel(name: LocalizationKeys.arabic.tr.obs, isSelected: false.obs)
        .obs,
    FilterChipModel(
            name: LocalizationKeys.math_prep.tr.obs, isSelected: false.obs)
        .obs,
    FilterChipModel(
            name: LocalizationKeys.math_1_secondary.tr.obs,
            isSelected: false.obs)
        .obs,
    FilterChipModel(
            name: LocalizationKeys.math_2_secondary.tr.obs,
            isSelected: false.obs)
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
    FilterChipModel(
            name: LocalizationKeys.philosophy.tr.obs, isSelected: false.obs)
        .obs,
    FilterChipModel(
            name: LocalizationKeys.psychology.tr.obs, isSelected: false.obs)
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

  Future<void> applyFilter() async {
    String? highSchool = selectEducationSecondary.value
        ? FireStoreNames.educationLevelSecondaryValue
        : null;
    String? midSchool = selectEducationPrep.value
        ? FireStoreNames.educationLevelPrepValue
        : null;

    double? minPrice =
        sliderStartValue.value == _minRating ? null : sliderStartValue.value;
    double? maxPrice =
        sliderEndValue.value == _maxRating ? null : sliderEndValue.value;

    List<Rx<FilterChipModel>>? selectedMaterials =
        materials.where((material) => material.value.isSelected.value).toList();

    if (selectedMaterials.isEmpty) {
      selectedMaterials = null;
    }

    await _teachersListViewModel.getTeachersList(isFilterApplied,
        highSchool: highSchool,
        midSchool: midSchool,
        minPrice: minPrice,
        maxPrice: maxPrice,
        selectedMaterials: selectedMaterials);
  }

  Future<void> resetFilters() async {
    selectEducationSecondary.value = false;
    selectEducationPrep.value = false;

    sliderStartValue.value = _minRating;
    sliderEndValue.value = _maxRating;

    for (var filterModel in materials) {
      filterModel.value.isSelected.value = false;
    }

    selectedFilters.clear();
    isFilterApplied = false;

    await applyFilter();
    addSelectedFiltersOnHomeScreen();
  }

  RxList<String> addSelectedFiltersOnHomeScreen() {
    if (selectEducationPrep.value) {
      selectedFilters.add(LocalizationKeys.education_prep.tr);
    }
    if (selectEducationSecondary.value) {
      selectedFilters.add(LocalizationKeys.education_secondary.tr);
    }
    for (var materialFilter in materials) {
      if (materialFilter.value.isSelected.value) {
        selectedFilters.add(materialFilter.value.name.value);
      }
    }
    if (sliderStartValue.value != _minRating) {
      selectedFilters.add(
          LocalizationKeys.price_from.tr + sliderStartValue.value.toString());
    }
    if (sliderEndValue.value != _maxRating) {
      selectedFilters
          .add(LocalizationKeys.price_to.tr + sliderEndValue.value.toString());
    }
    return selectedFilters;
  }
}
