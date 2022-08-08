import 'package:flutter/material.dart';

enum Environment { dev, prod }

class AppConfig extends InheritedWidget {
  final Environment environment;

  // 4
  const AppConfig({
    Key? key,
    required Widget child,
    required this.environment,
  }) : super(
          key: key,
          child: child,
        );

  // 5
  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>()!;
  }

  // 6
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
