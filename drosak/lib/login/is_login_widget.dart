import 'package:drosak/login/viewmodel/login_view_model.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/managers/assets_manager.dart';
import 'package:drosak/utils/managers/color_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'view/login_phone_or_social_screen.dart';

class IsLoginWidget extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  IsLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginViewModel _loginViewModel = Get.put(LoginViewModel());
    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;

    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      initialData: _auth.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return PhoneOrSocialLoginScreen();
        }

        //facebook login and google login if first time login
        _loginViewModel
            .loginUserToFireStore(snapshot.data!)
            .then((value) => null);

        return Container(
          color: ColorManager.deepPurple,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(AssetsManager.login_loading,
                    width: unitHeightValue * 40, height: unitHeightValue * 40),
                Text(LocalizationKeys.loading.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: unitHeightValue * 2.5,
                        fontWeight: FontWeight.bold))
              ]),
        );
      },
    );
  }
}
