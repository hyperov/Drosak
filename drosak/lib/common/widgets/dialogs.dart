import 'package:drosak/bookings/viewmodel/booking_view_model.dart';
import 'package:drosak/follows/viewmodel/follows_viewmodel.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

openDeleteDialog(GetxController viewModel, String id,
    [String? teacherId, String? lectureId]) {
  var isFollowsViewModel = viewModel is FollowsViewModel;
  var isBookingsViewModel = viewModel is BookingsViewModel;
  Get.dialog(
    AlertDialog(
      title: Column(children: [
        const Icon(
          Icons.delete_outline,
          color: Colors.red,
          size: 30,
        ),
        const SizedBox(height: 8),
        Text(isFollowsViewModel
            ? LocalizationKeys.delete_follow.tr
            : isBookingsViewModel
                ? LocalizationKeys.cancel_booking.tr
                : LocalizationKeys.cancel_booking.tr),
      ]),
      content: isFollowsViewModel
          ? Text(LocalizationKeys.follow_delete_question.tr)
          : isBookingsViewModel
              ? Text(LocalizationKeys.booking_delete_question.tr)
              : Text(LocalizationKeys.follow_delete_question.tr),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          child: Text(LocalizationKeys.app_no.tr,
                  style: const TextStyle(fontSize: 20))
              .marginSymmetric(horizontal: 16),
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () => Get.back(),
        ),
        ElevatedButton(
          child: Text(
            LocalizationKeys.app_yes.tr,
            style: const TextStyle(fontSize: 20),
          ).marginSymmetric(horizontal: 16),
          style: ElevatedButton.styleFrom(
            primary: ColorManager.blueLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () async {
            Get.back();
            if (isFollowsViewModel) {
              await viewModel.unfollowTeacher(id);
            } else if (isBookingsViewModel) {
              await viewModel.cancelBooking(id, teacherId!);
              await Workmanager().cancelByUniqueName(lectureId!);
            }
          },
        ),
      ],
    ),
  );
}
