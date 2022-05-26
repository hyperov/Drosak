import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

showListBottomSheet(
    {required List<Icon> leadingIcons,
    required List<String> texts,
    required RxString selectedText}) {
  Get.bottomSheet(
    ListView.builder(
        itemCount: leadingIcons.length,
        itemBuilder: (context, index) {
          return Obx(() => ListTile(
                leading: leadingIcons[index],
                title: Text(texts[index]),
                selected: selectedText.value == texts[index],
                onTap: () {
                  selectedText.value = texts[index];
                  Get.back();
                },
              ));
        }),
    backgroundColor: Colors.white,
  );
}
