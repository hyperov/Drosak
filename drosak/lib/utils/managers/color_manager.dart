import 'dart:ui';

import 'package:flutter/material.dart';

class ColorManager {
  static const Color goldenYellow = Color(0xfffcb727);
  static const Color redOrangeLight = Color(0xfffae0d8);
  static const Color redOrangeDark = Color(0xffffc2c0);
  static const Color greyLight = Color(0xfffef9f7);
  static const Color blueLight = Color(0xff7291f9);
  static const Color blueDark = Color(0xff3b3086);
  static const Color deepPurple = Color(0xff7b3c9f);
  static const Color lightPurple = Color(0xffe66bba);

  static MaterialColor deepPurpleMaterial = MaterialColor(deepPurple.value, {
    50: ColorManager.deepPurple.withOpacity(0.1),
    100: ColorManager.deepPurple.withOpacity(0.2),
    200: ColorManager.deepPurple.withOpacity(0.3),
    300: ColorManager.deepPurple.withOpacity(0.4),
    400: ColorManager.deepPurple.withOpacity(0.5),
    500: ColorManager.deepPurple.withOpacity(0.6),
    600: ColorManager.deepPurple.withOpacity(0.7),
    700: ColorManager.deepPurple.withOpacity(0.8),
    800: ColorManager.deepPurple.withOpacity(0.9),
    900: ColorManager.deepPurple.withOpacity(1),
  });
}
