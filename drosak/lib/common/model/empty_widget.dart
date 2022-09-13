import 'package:drosak/utils/managers/color_manager.dart';
import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/managers/assets_manager.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    return EmptyWidget(
      image: null,
      packageImage: PackageImage.Image_3,
      title: title, hideBackgroundAnimation: true,
      // subTitle: 'No  notification available yet',
      titleTextStyle: TextStyle(
        fontSize: unitHeightValue * 2.5,
        color: ColorManager.blueDark,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.bold,
      ),
      subtitleTextStyle: const TextStyle(
        fontSize: 14,
        color: ColorManager.goldenYellow,
      ),
    );
  }
}
