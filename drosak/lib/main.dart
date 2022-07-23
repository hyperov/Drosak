import 'package:drosak/app/main_app.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
// Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  await GetStorage.init();

  var fcmToken = await FirebaseMessaging.instance.getToken();
  await _saveFcmToken(fcmToken!);

  // fired at each app startup and whenever a new
  // token is generated.
  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
    await _saveFcmToken(fcmToken);
    if (kDebugMode) {
      print("FCM token new : $fcmToken");
    }
  }).onError((err) {
    if (kDebugMode) {
      print("FCM token error : $err");
    }
  });
  runApp(const MainApp());
}

_saveFcmToken(String token) async {
  await GetStorage().write(StorageKeys.fcmToken, token);
}
