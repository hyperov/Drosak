import 'package:drosak/bookings/viewmodel/booking_view_model.dart';
import 'package:drosak/follows/viewmodel/follows_viewmodel.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

openDeleteDialog(GetxController viewModel, String id,
    [String? teacherId, String? lectureId]) {
  var isFollowsViewModel = viewModel is FollowsViewModel;
  var isBookingsViewModel = viewModel is BookingsViewModel;
  var unitHeightValue = MediaQuery.of(Get.context!).size.height * 0.01;
  Get.dialog(
    AlertDialog(
      title: Column(children: [
        const Icon(
          Icons.delete_forever,
          color: Colors.red,
          size: 30,
        ),
        const SizedBox(height: 8),
        Text(
            isFollowsViewModel
                ? LocalizationKeys.cancel_follow.tr
                : isBookingsViewModel
                    ? LocalizationKeys.cancel_booking.tr
                    : LocalizationKeys.cancel_booking.tr,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            )),
      ]),
      content: isFollowsViewModel
          ? Text(LocalizationKeys.follow_delete_question.tr,
              style: TextStyle(
                fontSize: unitHeightValue * 2,
              ))
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
                  style: const TextStyle(fontSize: 16))
              .marginSymmetric(horizontal: 16),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () => Get.back(),
        ),
        ElevatedButton(
          child: Text(
            LocalizationKeys.app_yes.tr,
            style: const TextStyle(fontSize: 16),
          ).marginSymmetric(horizontal: 16),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () async {
            Get.back();
            if (isFollowsViewModel) {
              await viewModel.unfollowTeacher(id);
              FirebaseAnalytics.instance
                  .logEvent(name: "unfollow_teacher_success");
            } else if (isBookingsViewModel) {
              await viewModel.cancelBooking(id, teacherId!);
              await Workmanager().cancelByUniqueName(lectureId!);
              FirebaseAnalytics.instance
                  .logEvent(name: "cancel_booking_success");
            }
          },
        ),
      ],
    ),
  );
}
