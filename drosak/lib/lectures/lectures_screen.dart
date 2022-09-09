import 'package:drosak/bookings/viewmodel/booking_view_model.dart';
import 'package:drosak/common/widgets/bottomsheet.dart';
import 'package:drosak/teachers/model/teacher.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/src/panel.dart';

import '../common/model/empty_widget.dart';
import '../utils/localization/localization_keys.dart';
import 'viewmodel/lectures_viewmodel.dart';

class LecturesScreen extends StatelessWidget {
  const LecturesScreen(
      {Key? key, required this.teacher, required this.slidingUpPanelController})
      : super(key: key);

  final PanelController slidingUpPanelController;
  final Teacher teacher;

  LecturesViewModel get _lecturesViewModel => Get.put(LecturesViewModel());

  BookingsViewModel get _bookingsViewModel => Get.find();

  @override
  Widget build(BuildContext context) {
    FirebaseCrashlytics.instance.log('LecturesScreen');
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'firebase_screen': 'lectures_screen',
        'firebase_screen_class': 'LecturesScreen',
      },
    );
    return Obx(() => Scaffold(
          backgroundColor: ColorManager.redOrangeLight,
          body: _lecturesViewModel.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : _lecturesViewModel.lectures.isNotEmpty
                  ? ListView.builder(
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
                                  Text(
                                    _lecturesViewModel
                                        .lectures[index].centerName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
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
                                      SvgPicture.asset(AssetsManager.pin),
                                      const SizedBox(width: 8),
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
                                            SvgPicture.asset(
                                                AssetsManager.calendar),
                                            Text(
                                                _lecturesViewModel
                                                    .lectures[index].day,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                          ],
                                        ),
                                        Container(
                                          height: 1,
                                          width: 60,
                                          color: Colors.black,
                                        ),
                                        Column(
                                          children: [
                                            SvgPicture.asset(
                                                AssetsManager.clock),
                                            Text(
                                                _lecturesViewModel
                                                    .lectures[index].time,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                          ],
                                        ),
                                        Container(
                                          height: 1,
                                          width: 60,
                                          color: Colors.black,
                                        ),
                                        Column(
                                          children: [
                                            SvgPicture.asset(
                                                AssetsManager.money),
                                            Text(
                                                "${_lecturesViewModel.lectures[index].price.toString()}ج ",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16)),
                                          ],
                                        )
                                      ]),
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 16),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        FirebaseCrashlytics.instance.log(
                                            'LecturesScreen: book button clicked');
                                        FirebaseAnalytics.instance.logEvent(
                                          name: 'book_button_click',
                                          parameters: {
                                            'firebase_screen': 'book_screen',
                                            'firebase_screen_class':
                                                'BookScreen',
                                          },
                                        );
                                        _bookingsViewModel.selectedTeacher =
                                            teacher;
                                        showConfirmBookingBottomSheet(
                                            context,
                                            _lecturesViewModel,
                                            _bookingsViewModel,
                                            index,
                                            teacher,
                                            slidingUpPanelController);
                                      },
                                      child: Text(
                                        LocalizationKeys.booking.tr,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w100),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.deepPurple,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                      child: const Icon(
                                        Icons.school,
                                        color: ColorManager.blueDark,
                                        size: 32,
                                      ).marginAll(14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )))),
                        ]);
                      },
                      itemCount: _lecturesViewModel.lectures.length,
                      physics: const BouncingScrollPhysics(),
                    ).marginOnly(top: 16)
                  : EmptyView(title: LocalizationKeys.lectures_not_found.tr),
        ));
  }
}
