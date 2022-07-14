import 'package:drosak/follows/viewmodel/follows_viewmodel.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FollowItem extends StatelessWidget {
  const FollowItem(
      {Key? key, required this.followsViewModel, required this.index})
      : super(key: key);

  final FollowsViewModel followsViewModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Stack(
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Card(
                      color: Colors.deepPurple,
                      elevation: 4,
                      clipBehavior: Clip.hardEdge,
                      shape: const CircleBorder(
                          side: BorderSide(
                              color: Colors.deepPurpleAccent, width: 1)),
                      child: Obx(() => Image.network(
                              followsViewModel.follows[index].teacherPhotoUrl,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                            return SvgPicture.asset(
                              AssetsManager.profilePlaceHolder,
                              width: 70,
                              height: 70,
                              color: Colors.white,
                              fit: BoxFit.cover,
                            );
                          })),
                    ),
                    Positioned(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.deepPurpleAccent),
                          borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(16),
                              right: Radius.circular(16)),
                        ),
                        child: Row(children: [
                          SvgPicture.asset(
                            AssetsManager.star,
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                              followsViewModel.follows[index].rating.toString(),
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.black)),
                        ]),
                      ),
                      bottom: -5,
                    ),
                  ],
                ),
                const SizedBox(width: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(followsViewModel.follows[index].teacherName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(followsViewModel.follows[index].material),
                    Text(followsViewModel.follows[index].getEducationText()),
                  ],
                ),
              ],
            ),
            PositionedDirectional(
              end: 16,
              bottom: 16,
              top: 16,
              child: ElevatedButton.icon(
                onPressed: () {
                  followsViewModel.unfollowTeacher(
                      followsViewModel.follows[index].teacherName, index);
                },
                icon: const Icon(
                  Icons.done,
                  color: Colors.deepPurpleAccent,
                ),
                label: Text(LocalizationKeys.follows.tr,
                    style: const TextStyle(
                        fontSize: 14, color: Colors.deepPurpleAccent)),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    side: const BorderSide(color: Colors.deepPurpleAccent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
