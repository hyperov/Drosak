import 'package:drosak/app/main_app.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jiffy/jiffy.dart';
import 'package:workmanager/workmanager.dart';

import 'firebase_options.dart';
import 'utils/managers/color_manager.dart';
import 'utils/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  //work manager for background tasks
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          false // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );

  await GetStorage.init();
  Jiffy.locale('ar');

  var fcmToken = await FirebaseMessaging.instance.getToken();
  print("FCM token new : $fcmToken");
  await _saveFcmToken(fcmToken!);

  // fired at each app startup and whenever a new
  // token is generated.
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
    await _saveFcmToken(fcmToken);
    if (kDebugMode) {
      print("FCM token refresh : $fcmToken");
    }
  }).onError((err) {
    if (kDebugMode) {
      print("FCM token error : $err");
    }
  });
  initializeEasyLoading();

  runApp(const MainApp());
}

_saveFcmToken(String token) async {
  await GetStorage().write(StorageKeys.fcmToken, token);
}

initializeEasyLoading() async {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.wanderingCubes
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = ColorManager.redOrangeLight
    ..backgroundColor = ColorManager.blueDark
    ..indicatorColor = ColorManager.redOrangeDark
    ..textColor = ColorManager.redOrangeDark
    // ..maskColor = ColorManager.blueLight.withOpacity(0.5)
    ..maskColor = ColorManager.blueDark.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.custom
    ..errorWidget = const Icon(
      Icons.error_outline,
      color: Colors.red,
      size: 45.0,
    )
    ..userInteractions = true
    ..dismissOnTap = true;
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    if (task == 'book_lecture_task') {
      await createAndroidNotification(
          null,
          RemoteMessage(
              notification: RemoteNotification(
            title: 'بنفكرك بحصة ${inputData!['material']} اللى انت حاجزها ',
            body:
                'الموعد المحدد هو ${inputData['lec_date']} يوم ${inputData['day']} الساعة ${inputData['time']}',
          )));
    }
    if (kDebugMode) {
      print("Native called background task: $task");
    } //simpleTask will be emitted here.
    return Future.value(true);
  });
}
