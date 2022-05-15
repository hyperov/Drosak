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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
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
                    hintText: LocalizationKeys.phone_number.tr,
                    label: Text(LocalizationKeys.phone_number_hint.tr),
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
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                SignInButton(Buttons.Email,
                    text: LocalizationKeys.app_login.tr, onPressed: () {}),
                SignInButton(Buttons.FacebookNew,
                    text: LocalizationKeys.login_facebook.tr, onPressed: () {}),
                SignInButton(Buttons.Google,
                    text: LocalizationKeys.login_google.tr, onPressed: () {}),
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
