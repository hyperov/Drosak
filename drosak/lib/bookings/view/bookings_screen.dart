import 'package:drosak/bookings/viewmodel/booking_view_model.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                                  Text(_bookingsViewModel
                                      .bookings[index].centerName),
                                  const SizedBox(height: 0),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(_bookingsViewModel
                                          .bookings[index].classLevel),
                                      const Text(' / '),
                                      Text(_bookingsViewModel
                                          .bookings[index].material),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.location_pin),
                                      Text(_bookingsViewModel
                                          .bookings[index].city),
                                      const Text(' - '),
                                      Text(_bookingsViewModel
                                          .bookings[index].area),
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
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 32, vertical: 16),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // showConfirmDeleteBookingDialog(context,
                                        //     _bookingsViewModel, index, teacher);
                                      },
                                      child: Text(LocalizationKeys.booking.tr),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.deepPurple,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                      itemCount: _bookingsViewModel.bookings.length,
                      physics: const BouncingScrollPhysics(),
                    )
                  : Center(
                      child: Text(LocalizationKeys.lectures_not_found.tr),
                    ),
        ));
  }
}
