import 'package:drosak/login/login_view_model.dart';
import 'package:drosak/utils/localization_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginViewModel viewModel = Get.put(LoginViewModel());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFFFFC2C0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                SizedBox(height: 100),
                Image.asset('assets/launcher/logo2.png',height: 200,),
                SizedBox(height: 30),
                Text(
                  LocalizationKeys.enter_phone_number.tr,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(LocalizationKeys.phone_confirmation.tr),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: LocalizationKeys.phone_number_hint.tr,
                    label: Text(LocalizationKeys.phone_number.tr),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
                SizedBox(height: 30),
                SignInButtonBuilder(
                  text: LocalizationKeys.app_login.tr,
                  textColor: Colors.black,
                  icon: Icons.phone_android,
                  iconColor: Colors.pinkAccent,
                  backgroundColor: Colors.white,
                  onPressed: () {},
                  height: 50,
                  elevation: 2,
                  splashColor: Colors.white30,
                  fontSize: 16,
                  width: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                SignInButton(Buttons.FacebookNew,
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    text: LocalizationKeys.login_facebook.tr,
                    onPressed: () {}),
                SignInButton(Buttons.Google,
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    text: LocalizationKeys.login_google.tr,
                    onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  error(String message) => Get.snackbar(message, '',
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2));

  success(String message) => Get.snackbar(message, '',
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2));
}
