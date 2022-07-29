import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drosak/notifications/model/entity/notification_item.dart';
import 'package:drosak/notifications/model/repo/notification_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class NotificationsViewModel extends GetxController {
  final _notificationsRepo = NotificationRepo();

  var notificationList = <NotificationItem>[].obs;

  RxBool isLoading = false.obs;

  late StreamSubscription<QuerySnapshot<NotificationItem>> notificationListen;

  @override
  void onInit() async {
    super.onInit();
    await getNotifications();
  }

  Future<void> getNotifications() async {
    isLoading.value = true;

    var _notificationsStream = _notificationsRepo
        .getStudentNotifications(FirebaseAuth.instance.currentUser!.uid);

    notificationListen = _notificationsStream.listen((_notifications) {
      var notificationDocs = _notifications.docs.map((doc) {
        var notification = doc.data();
        return notification;
      });

      isLoading.value = false;
      notificationList.clear();
      notificationList.addAll(notificationDocs);
    }, onError: (e) {
      isLoading.value = false;
      print(e);
    });
  }

  @override
  void onClose() {
    notificationListen.cancel();
    super.onClose();
  }
}
