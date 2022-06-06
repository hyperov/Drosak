import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class TeacherDetailsScreen extends StatelessWidget {
  TeacherDetailsScreen({Key? key}) : super(key: key);

  var classes = [
    'الصف الاول الثانوي',
    'الصف الثاني الثانوي',
    'الصف الثالث الثانوي',
    'الصف الاول الاعدادي',
    'الصف الثاني الاعدادي',
    'الصف الثالث الاعدادي',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Details'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person),
            ),
            const Text('احمد نبيل', style: const TextStyle(fontSize: 30)),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Marquee(
                text: classes
                    .toString()
                    .replaceAll('[', '')
                    .replaceAll(']', '')
                    .replaceAll(',', ' - '),
                style: const TextStyle(fontSize: 20),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                blankSpace: 20,
              ),
            ),
            SizedBox(
              height: 40,
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    ' ثانوى ',
                    textStyle: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w300,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                  TyperAnimatedText(
                    'اعدادى',
                    textStyle: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w300,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 4,
                pause: const Duration(milliseconds: 300),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
                repeatForever: true,
              ),
            ),
            Text(LocalizationKeys.math.tr,
                style: const TextStyle(fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Icon(
                    Icons.star,
                    color: Colors.blue,
                  ),
                  onPressed: () {},
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: const EdgeInsets.all(8),
                      minimumSize: const Size(120, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )),
                  child: const Text(
                    "متابعة",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {},
                ).marginSymmetric(horizontal: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    // minimumSize: Size(60, 50),
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Icon(
                    Icons.heart_broken_outlined,
                    color: Colors.blue,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 48),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Icon(Icons.people, color: Colors.blue),
                        const SizedBox(height: 8),
                        Text(LocalizationKeys.followers.tr,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.grey)),
                        const SizedBox(height: 8),
                        const Text("120",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Icon(Icons.star, color: Colors.blue),
                        const SizedBox(height: 8),
                        Text(LocalizationKeys.rating.tr,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.grey)),
                        const SizedBox(height: 8),
                        const Text("4.5",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16, vertical: 16),
            ).marginSymmetric(horizontal: 65),
            const SizedBox(height: 48),
            // TabBar(tabs: [
            //   Tab(
            //     child: Text(LocalizationKeys.lectures.tr),
            //   ),
            //   Tab(
            //     child: Text(LocalizationKeys.reviews.tr),
            //   ),
            // ]),
          ],
        ),
      ),
    );
  }
}
