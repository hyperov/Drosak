import 'package:drosak/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'view/login_phone_or_social_screen.dart';

class IsLoginWidget extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  IsLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      initialData: _auth.currentUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen(title: "drosak");
        } else {
          return PhoneOrSocialLoginScreen();
        }
      },
    );
  }
}
