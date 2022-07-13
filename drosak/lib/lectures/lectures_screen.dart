import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../utils/localization/localization_keys.dart';
import 'viewmodel/lectures_viewmodel.dart';

class LecturesScreen extends StatelessWidget {
  const LecturesScreen({Key? key}) : super(key: key);

  LecturesViewModel get _lecturesViewModel => Get.put(LecturesViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: ColorManager.redOrangeLight,
          body: _lecturesViewModel.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : _lecturesViewModel.lectures.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Slidable(
                          startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: 0.25,
                              // A pane can dismiss the Slidable.
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Card(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.edit,
                                                      color: Colors.deepPurple),
                                                  Text(
                                                    LocalizationKeys.edit.tr,
                                                    style: const TextStyle(
                                                        color:
                                                            Colors.deepPurple,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: Colors.deepPurple,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.delete,
                                                      color: Colors.red),
                                                  Text(
                                                    LocalizationKeys
                                                        .app_delete.tr,
                                                    style: const TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: () {},
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                          child: Stack(children: [
                            Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                              child: InkWell(
                                onTap: () {},
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 16),
                                      Text(_lecturesViewModel
                                          .lectures[index].centerName),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(_lecturesViewModel
                                              .lectures[index].classLevel),
                                          const Text(' / '),
                                          Text(_lecturesViewModel
                                              .lectures[index].material),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.location_pin),
                                          Text(_lecturesViewModel
                                              .lectures[index].city),
                                          const Text(' - '),
                                          Text(_lecturesViewModel
                                              .lectures[index].area),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                const Icon(
                                                    Icons.calendar_today),
                                                Text(_lecturesViewModel
                                                    .lectures[index].day),
                                              ],
                                            ),
                                            Container(
                                              height: 1,
                                              width: 60,
                                              color: Colors.black,
                                            ),
                                            Column(
                                              children: [
                                                const Icon(Icons.punch_clock),
                                                Text(_lecturesViewModel
                                                    .lectures[index].time),
                                              ],
                                            ),
                                            Container(
                                              height: 1,
                                              width: 60,
                                              color: Colors.black,
                                            ),
                                            Column(
                                              children: [
                                                const Icon(Icons.money),
                                                Text(
                                                    "${_lecturesViewModel.lectures[index].price.toString()}ج "),
                                              ],
                                            )
                                          ]),
                                      const SizedBox(height: 16),
                                    ]),
                              ),
                            ),
                            PositionedDirectional(
                                child: Center(
                                    child: Card(
                                        elevation: 4,
                                        color: Colors.white,
                                        child: const Icon(Icons.school)
                                            .marginAll(6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )))),
                          ]),
                        );
                      },
                      itemCount: _lecturesViewModel.lectures.length,
                      physics: const BouncingScrollPhysics(),
                    )
                  : Center(
                      child: Text(LocalizationKeys.lectures_not_found.tr),
                    ),
        ));
  }
}
