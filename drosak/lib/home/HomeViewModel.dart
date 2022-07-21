import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import 'notification_model.dart';

class HomeViewModel extends RxController {
  RxInt bottomNavigationIndex = 0.obs;
  late var fcmToken;

  late FirebaseMessaging _messaging;

  @override
  Future<void> onInit() async {
    checkForInitialMessage();
    super.onInit();
    fcmToken = await FirebaseMessaging.instance.getToken();
    print("FCM token: $fcmToken");
    registerNotification();

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      // TODO: If necessary send token to application server.
      fcmToken = fcmToken;
      print("FCM token new : $fcmToken");
      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    }).onError((err) {
      // Error getting token.
    });
  }

  void registerNotification() async {
    _messaging = FirebaseMessaging.instance;

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // TODO: handle the received notifications

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // foreground: app is in foreground
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        // background but not terminated
        //handle navigation
        print("onMessageOpenedApp: $message");
      });

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    } else {
      print('User declined or has not accepted permission');
    }
  }

  checkForInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    print("initialMessage: $initialMessage");
    if (initialMessage != null) {
      NotificationModel notification = NotificationModel(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
    }
  }
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.data}");
}
