import 'package:drosak/utils/managers/color_manager.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jiffy/jiffy.dart';

import '../../utils/firestore_names.dart';
import '../viewmodel/reviews_viewmodel.dart';

class ReviewsScreen extends StatelessWidget {
  ReviewsScreen({Key? key, required this.scrollController}) : super(key: key);

  ReviewsViewModel get _reviewsViewModel => Get.put(ReviewsViewModel());
  final _storage = GetStorage();
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.redOrangeLight,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Obx(() =>
                Text('تقييمات الطلاب (${_reviewsViewModel.reviews.length} )')
                    .marginSymmetric(horizontal: 16)),
            Card(
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
              child: PopupMenuButton(
                  child: Row(
                    children: const [
                      Text("الترتيب",
                          style: TextStyle(fontSize: 14, color: Colors.blue)),
                      Icon(Icons.keyboard_arrow_down, color: Colors.blue),
                    ],
                  ).paddingSymmetric(horizontal: 16, vertical: 16),
                  initialValue: "الترتيب حسب الأحدث",
                  onSelected: (selected) {
                    _reviewsViewModel.orderBy.value = selected.toString();
                  },
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        child: Text('الترتيب حسب الأحدث'),
                        value: FireStoreNames
                            .collectionTeacherReviewsSortFieldDate,
                      ),
                      const PopupMenuItem(
                        child: Text('الترتيب حسب الأكثر تقييما'),
                        value: FireStoreNames
                            .collectionTeacherReviewsSortFieldRating,
                      ),
                    ];
                  }),
            ),
          ]),
          Card(
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_storage.read(StorageKeys.teacherRating)?.toString() ??
                      '0'),
                  RatingBar.builder(
                    initialRating: _storage
                            .read<double>(StorageKeys.teacherRating)
                            ?.toDouble() ??
                        0.0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    ignoreGestures: true,
                    unratedColor: Colors.grey,
                    itemSize: 26,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (double value) {},
                  ),
                  const Text('التقييم الكلى للمدرس',
                      style: TextStyle(color: Colors.black)),
                ],
              ).paddingSymmetric(horizontal: 16, vertical: 16)),
          Expanded(
            child: Obx(() => ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.yellow),
                            Obx(() => Text(
                                  _reviewsViewModel.reviews.value[index].rating
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                )),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Obx(() =>
                            Text(_reviewsViewModel.reviews.value[index].body)),
                        const SizedBox(height: 16),

                        // ,TimeOfDayFormat.h_colon_mm_space_a
                        Obx(() => Text(
                            Jiffy(_reviewsViewModel.reviews.value[index].date)
                                .format("dd MMM yyyy"),
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey))),
                      ],
                    ).paddingSymmetric(horizontal: 16, vertical: 16),
                  );
                },
                physics: const BouncingScrollPhysics(),
                itemCount: _reviewsViewModel.reviews.length)),
          ),
        ],
      ),
    );
  }
}
