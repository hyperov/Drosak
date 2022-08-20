import 'package:drosak/utils/managers/color_manager.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return EmptyWidget(
      image: null,
      packageImage: PackageImage.Image_3,
      title: title, hideBackgroundAnimation: true,
      // subTitle: 'No  notification available yet',
      titleTextStyle: const TextStyle(
        fontSize: 22,
        color: ColorManager.blueDark,
        fontWeight: FontWeight.bold,
      ),
      subtitleTextStyle: const TextStyle(
        fontSize: 14,
        color: ColorManager.goldenYellow,
      ),
    );
  }
}
