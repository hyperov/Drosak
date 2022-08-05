import 'package:drosak/common/widgets/bottomsheet.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FullWidthTextField extends StatelessWidget {
  const FullWidthTextField(
      {Key? key,
      required this.leadingIcons,
      required this.texts,
      required this.selectedText})
      : super(key: key);

  final List<Icon> leadingIcons;
  final List<String> texts;
  final RxString selectedText;

  @override
  Widget build(BuildContext context) {
    return Container(
      //male or female
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: ColorManager.deepPurple)),
      child: InkWell(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          showListBottomSheet(
              leadingIcons: leadingIcons,
              texts: texts,
              selectedText: selectedText);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() => Text(
                selectedText.value,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )),
        ),
      ),
    );
  }
}
