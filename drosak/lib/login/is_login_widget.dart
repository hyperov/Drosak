import 'package:drosak/home/teachers_list_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_phone_or_social_screen.dart';

class IsLoginWidget extends StatelessWidget {
  final FirebaseAuth auth = Get.put(FirebaseAuth.instance);

  IsLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const TeachersListHomeScreen(title: "drosak");
        } else {
          return PhoneOrSocialLoginScreen();
        }
      },
    );
  }
}
