import 'dart:math';

import 'package:drosak/home/home_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../home/notification_model.dart';
import 'managers/color_manager.dart';

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late FirebaseMessaging _messaging;

Future<void> createAndroidNotification(
    RemoteNotification? notification, RemoteMessage? message) async {
  var androidNotification = notification?.android;

  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    androidNotification?.channelId ?? 'default_channel',
    'Drosak',
    channelDescription: 'Drosak channel for notifications',
    icon: '@mipmap/ic_launcher',
    largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    playSound: true,
    enableVibration: true,
    enableLights: true,
    importance: Importance.max,
    priority: Priority.max,
    color: ColorManager.deepPurple,
    visibility: NotificationVisibility.public,
    colorized: true,
    ledColor: ColorManager.goldenYellow,
    ledOnMs: 1000,
    ledOffMs: 3000,
    number: 1,
    fullScreenIntent: true,
  );

  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  if (message?.notification != null) {
    await flutterLocalNotificationsPlugin.show(
        Random().nextInt(100),
        message?.notification?.title,
        message?.notification?.body,
        platformChannelSpecifics,
        payload: 'item x');
  } else {
    await initLocalNotifications();
    await flutterLocalNotificationsPlugin.show(Random().nextInt(100),
        'باقى اقل من 24 ساعة على الحصة', 'تاريخ', platformChannelSpecifics,
        payload: 'item x');
  }
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

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // foreground: app is in foreground
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        await createAndroidNotification(message.notification!, message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // background but not terminated
      //handle navigation
      print("onMessageOpenedApp: $message");
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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

Future<bool?> initLocalNotifications() async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('logo2');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  return flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: _onSelectNotification);
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.data}");
}

void _onSelectNotification(String? payload) {
  if (payload != null) {
    debugPrint('notification payload: ' + payload);
  }
  Get.to(() => HomeScreen());
}
