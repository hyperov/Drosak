import 'package:drosak/bindings/initial_bindings.dart';
import 'package:drosak/login/is_login_widget.dart';
import 'package:drosak/utils/localization/languages.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: ColorManager.deepPurple,
          primarySwatch: ColorManager.deepPurpleMaterial,
        ),
        home: IsLoginWidget(),
        debugShowCheckedModeBanner: true,
        locale: const Locale('ar', 'EG'),
        translations: Languages(),
        initialBinding: InitialBindings(),
      ),
    );
  }
}
