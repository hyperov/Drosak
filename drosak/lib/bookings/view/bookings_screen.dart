import 'package:drosak/bookings/viewmodel/booking_view_model.dart';
import 'package:drosak/common/widgets/dialogs.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class BookingsScreen extends StatelessWidget {
  BookingsScreen({Key? key}) : super(key: key);

  final BookingsViewModel _bookingsViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
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
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(_bookingsViewModel
                                        .bookings[index].classLevel),
                                    Text(_bookingsViewModel
                                        .bookings[index].material),
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
                                    Text(
                                      Jiffy(_bookingsViewModel
                                              .bookings[index].lecDate)
                                          .format("dd MMMM"),
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
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
                                              Text(_bookingsViewModel
                                                  .bookings[index].day),
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
                                              Text(_bookingsViewModel
                                                  .bookings[index].time),
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
                                                  "${_bookingsViewModel.bookings[index].price.toString()}ج "),
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
                                              child: Text(LocalizationKeys
                                                  .cancel_booking.tr),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.deepPurple,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(
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
                                        return SvgPicture.asset(
                                          AssetsManager.profilePlaceHolder,
                                          width: 70,
                                          height: 70,
                                          color: Colors.white,
                                          fit: BoxFit.cover,
                                        ).marginAll(16);
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
                                                    .substring(
                                                        0,
                                                        _bookingsViewModel
                                                            .bookings[index]
                                                            .teacherName
                                                            .length) +
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
                  : Center(
                      child: Text(LocalizationKeys.lectures_not_found.tr),
                    ),
        ));
  }
}
