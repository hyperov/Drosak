import 'package:drosak/bindings/initial_bindings.dart';
import 'package:drosak/login/is_login_widget.dart';
import 'package:drosak/utils/localization/languages.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: AssetsManager.fontFamily,
          primaryColor: ColorManager.deepPurple,
          primarySwatch: ColorManager.deepPurpleMaterial,
          scaffoldBackgroundColor: ColorManager.redOrangeLight,
        ),
        home: IsLoginWidget(),
        debugShowCheckedModeBanner: kDebugMode,
        locale: const Locale('ar', 'EG'),
        translations: Languages(),
        initialBinding: InitialBindings(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
