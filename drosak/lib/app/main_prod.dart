import 'package:drosak/config/app_config.dart';
import 'package:drosak/firebase/prod/firebase_options.dart';
import 'package:drosak/shared_main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'main_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await sharedMain();
  const configuredApp =
      AppConfig(child: MainApp(), environment: Environment.prod);

  runApp(configuredApp);
}
