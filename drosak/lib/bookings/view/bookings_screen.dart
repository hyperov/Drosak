import 'package:drosak/bookings/viewmodel/booking_view_model.dart';
import 'package:drosak/common/model/empty_widget.dart';
import 'package:drosak/common/widgets/dialogs.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  BookingsViewModel get _bookingsViewModel => Get.find();

  @override
  Widget build(BuildContext context) {
    FirebaseCrashlytics.instance.log('BookingsScreen');
    FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'firebase_screen': 'bookings_screen',
        'firebase_screen_class': 'BookingsScreen',
      },
    );
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;

    return Obx(() => Scaffold(
          backgroundColor: ColorManager.redOrangeLight,
          body: _bookingsViewModel.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : _bookingsViewModel.bookings.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Stack(children: [
                          Stack(children: [
                            Card(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 0,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 42),
                                    Text(
                                      _bookingsViewModel
                                          .bookings[index].centerName,
                                      style: TextStyle(
                                          fontSize: unitHeightValue * 2.2,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        _bookingsViewModel
                                            .bookings[index].classLevel,
                                        style: TextStyle(
                                            fontSize: unitHeightValue * 2)),
                                    Text(
                                        _bookingsViewModel
                                            .bookings[index].material,
                                        style: TextStyle(
                                            fontSize: unitHeightValue * 1.8)),
                                    Text(
                                      Jiffy(_bookingsViewModel
                                              .bookings[index].lecDate)
                                          .format("dd MMMM"),
                                      style: TextStyle(
                                        fontSize: unitHeightValue * 1.8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(AssetsManager.pin,
                                            color: ColorManager.deepPurple),
                                        const SizedBox(width: 8),
                                        Text(_bookingsViewModel
                                            .bookings[index].city),
                                        const Text(' - '),
                                        Text(_bookingsViewModel
                                            .bookings[index].area),
                                      ],
                                    ),
                                    Text(_bookingsViewModel
                                        .bookings[index].address),
                                    const SizedBox(height: 8),
                                    // !_bookingsViewModel.bookings[index]
                                    //         .teacherPhone.isBlank!
                                    //     ? Row(
                                    //         children: [
                                    //           Text(LocalizationKeys
                                    //               .teacher_phone.tr),
                                    //           const SizedBox(width: 8),
                                    //           Text(
                                    //               _bookingsViewModel
                                    //                   .bookings[index]
                                    //                   .teacherPhone,
                                    //               style: const TextStyle(
                                    //                   fontSize: 16,
                                    //                   fontWeight:
                                    //                       FontWeight.bold)),
                                    //         ],
                                    //       )
                                    //     : const SizedBox(),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              SvgPicture.asset(
                                                  AssetsManager.calendar),
                                              Text(
                                                  _bookingsViewModel
                                                      .bookings[index].day,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          unitHeightValue *
                                                              1.8)),
                                            ],
                                          ),
                                          Container(
                                            height: 1,
                                            width: Get.width * 0.14,
                                            color: Colors.black,
                                          ),
                                          Column(
                                            children: [
                                              SvgPicture.asset(
                                                  AssetsManager.clock),
                                              Text(
                                                  _bookingsViewModel
                                                      .bookings[index].time,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          unitHeightValue *
                                                              1.8)),
                                            ],
                                          ),
                                          Container(
                                            height: 1,
                                            width: Get.width * 0.14,
                                            color: Colors.black,
                                          ),
                                          Column(
                                            children: [
                                              SvgPicture.asset(
                                                  AssetsManager.money),
                                              Text(
                                                  "${_bookingsViewModel.bookings[index].price.toString()}ج ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          unitHeightValue *
                                                              1.8)),
                                            ],
                                          )
                                        ]),
                                    !_bookingsViewModel
                                                .bookings[index].isCanceled &&
                                            _bookingsViewModel.bookings[index]
                                                .isBookingCancellable()
                                        ? Container(
                                            width: double.infinity,
                                            height: 48,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 16),
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                FirebaseAnalytics.instance.logEvent(
                                                    name:
                                                        "booking_cancel_dialog");
                                                openDeleteDialog(
                                                    _bookingsViewModel,
                                                    _bookingsViewModel
                                                        .bookings[index].id!,
                                                    _bookingsViewModel
                                                        .bookings[index]
                                                        .teacherId,
                                                    _bookingsViewModel
                                                        .bookings[index]
                                                        .lectureId);
                                              },
                                              child: Text(
                                                  LocalizationKeys
                                                      .cancel_booking.tr,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        unitHeightValue * 2.2,
                                                  )),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                              ),
                                            ),
                                          )
                                        : const SizedBox(
                                            height: 24,
                                          ),
                                  ]).marginSymmetric(horizontal: 24),
                            ),
                            PositionedDirectional(
                              top: 16,
                              end: 32,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 24),
                                    Card(
                                      clipBehavior: Clip.hardEdge,
                                      shape: const CircleBorder(
                                        side: BorderSide(
                                          color: Colors.deepPurpleAccent,
                                          width: 1,
                                        ),
                                      ),
                                      child: Image.network(
                                          _bookingsViewModel
                                              .bookings[index].teacherImageUrl,
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover, errorBuilder:
                                              (context, error, stackTrace) {
                                        return Image.asset(
                                          AssetsManager.teacher_empty_profile,
                                          width: 70,
                                          height: 70,
                                        );
                                      }),
                                    ),
                                    Text(
                                        _bookingsViewModel.bookings[index]
                                                    .teacherName.length <
                                                15
                                            ? _bookingsViewModel
                                                .bookings[index].teacherName
                                            : _bookingsViewModel
                                                    .bookings[index].teacherName
                                                    .substring(0, 15) +
                                                "...",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        )),
                                  ]),
                            )
                          ]),
                          PositionedDirectional(
                              top: 0,
                              start: 36,
                              child: Center(
                                  child: Card(
                                      elevation: 4,
                                      color: Colors.white,
                                      child: const Icon(
                                        Icons.school,
                                        color: Colors.deepPurple,
                                        size: 34,
                                      ).marginAll(14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      )))),
                        ]);
                      },
                      itemCount: _bookingsViewModel.bookings.length,
                      physics: const BouncingScrollPhysics(),
                    ).marginOnly(top: 16)
                  : EmptyView(title: LocalizationKeys.bookings_not_found.tr),
        ));
  }
}
