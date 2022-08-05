import 'package:drosak/notifications/viewmodel/notifications_viewmodel.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  NotificationsViewModel get _notificationsViewModel => Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => _notificationsViewModel.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : _notificationsViewModel.notificationList.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                          elevation: 0,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            style: ListTileStyle.list,
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.notifications,
                                    color: ColorManager.deepPurple),
                              ],
                            ),
                            title: Text(
                              _notificationsViewModel
                                  .notificationList[index].teacher!,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(_notificationsViewModel
                                .notificationList[index].message!),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Jiffy(_notificationsViewModel
                                          .notificationList[index].date)
                                      .format("dd MMM"),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ).paddingSymmetric(vertical: 16));
                    },
                    itemCount: _notificationsViewModel.notificationList.length,
                  ).paddingOnly(top: 20)
                : Center(
                    child: Text(LocalizationKeys.notifications_not_found.tr),
                  )));
  }
}
