import 'package:drosak/login/model/Repo/user_repo.dart';
import 'package:drosak/utils/notification.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeViewModel extends RxController {
  RxInt bottomNavigationIndex = 0.obs;

  final UserRepo _userRepo = Get.find();

  @override
  Future<void> onInit() async {
    checkForInitialMessage();
    super.onInit();

    GetStorage().listenKey(StorageKeys.fcmToken, (value) async {
      if (value != null && FirebaseAuth.instance.currentUser != null) {
        await _userRepo.updateFCMToken(value);
      }
    });

    registerNotification();
    var isInitNotification = await initLocalNotifications();
    if (!isInitNotification!) {
      return;
    }
  }
}
