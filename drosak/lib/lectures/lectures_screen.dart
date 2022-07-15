import 'package:drosak/common/widgets/bottomsheet.dart';
import 'package:drosak/teachers/model/teacher.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/src/panel.dart';

import '../utils/localization/localization_keys.dart';
import 'viewmodel/lectures_viewmodel.dart';

class LecturesScreen extends StatelessWidget {
  const LecturesScreen(
      {Key? key,
      required this.scrollController,
      required this.teacher,
      required this.slidingUpPanelController})
      : super(key: key);

  final ScrollController scrollController;
  final PanelController slidingUpPanelController;
  final Teacher teacher;

  LecturesViewModel get _lecturesViewModel => Get.put(LecturesViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: ColorManager.redOrangeLight,
          body: _lecturesViewModel.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : _lecturesViewModel.lectures.isNotEmpty
                  ? ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Stack(children: [
                          Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 42),
                                  Text(_lecturesViewModel
                                      .lectures[index].centerName),
                                  const SizedBox(height: 0),
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
                                  const SizedBox(height: 8),
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
                                            const Icon(Icons.calendar_today),
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
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 16),
                                    child: Visibility(
                                      visible: _lecturesViewModel
                                          .lectures[index].isEnabled,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showConfirmBookingBottomSheet(
                                              context,
                                              _lecturesViewModel,
                                              index,
                                              teacher,
                                              slidingUpPanelController);
                                        },
                                        child:
                                            Text(LocalizationKeys.booking.tr),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.deepPurple,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                          PositionedDirectional(
                              child: Center(
                                  child: Card(
                                      elevation: 4,
                                      color: Colors.white,
                                      child: const Icon(Icons.school)
                                          .marginAll(14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )))),
                        ]);
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
