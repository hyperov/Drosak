import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'teacher_details_screen.dart';

class TeachersList extends StatelessWidget {
  const TeachersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: ListView.builder(itemBuilder: (context, index) {
        return Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: () {
              Get.to(() => TeacherDetailsScreen());
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
              child: Stack(
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.person, size: 50),
                            radius: 25,
                          ),
                          Positioned(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.blue),
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(16),
                                    right: Radius.circular(16)),
                              ),
                              child: Row(children: [
                                Icon(Icons.star,
                                    size: 20, color: Colors.blue.shade800),
                                const Text('4.5',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.black)),
                              ]),
                            ),
                            bottom: -10,
                          ),
                        ],
                      ),
                      const SizedBox(width: 32),
                      Column(
                        children: const [
                          Text("اسلام حسام"),
                          Text("مدرس فيزياء"),
                          Text("ثانوى"),
                        ],
                      ),
                    ],
                  ),
                  PositionedDirectional(
                    end: 16,
                    bottom: 16,
                    top: 16,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("70-80 "),
                        Text("متوسط"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
