import 'package:drosak/home/teachers_list_home_screen.dart';
import 'package:drosak/login/enter_sms_code_screen.dart';
import 'package:drosak/login/login_view_model.dart';
import 'package:drosak/utils/localization_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

class PhoneOrSocialLoginScreen extends StatelessWidget {
  final LoginViewModel loginViewModel = Get.put(LoginViewModel());

  PhoneOrSocialLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ever(loginViewModel.errorSnackBarShow, (callback) {
      if (loginViewModel.errMessage.value != null &&
          loginViewModel.errorSnackBarShow.value) {
        Get.snackbar(
          loginViewModel.errMessage.value!,
          loginViewModel.errMessage.value!,
          backgroundColor: Colors.redAccent,
          dismissDirection: DismissDirection.up,
          duration: const Duration(seconds: 2),
          shouldIconPulse: true,
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
        );
        loginViewModel.errorSnackBarShow.value = false;
      }
    });

    ever(loginViewModel.isCodeSent, (callback) => Get.to(EnterSmsCodeScreen()));
    ever(loginViewModel.isLoggedIn, (callback) {
      if (loginViewModel.isLoggedIn.value) {
        Get.to(const TeachersListHomeScreen(title: "Drosak"));
        Get.snackbar(
          "Success",
          "You are logged in",
          backgroundColor: Colors.green,
          dismissDirection: DismissDirection.up,
          icon: const Icon(
            Icons.check,
            color: Colors.white,
          ),
        );
      }
    });
    return Scaffold(
      backgroundColor: const Color(0xFFFFC2C0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            child: Column(
              children: [
                const SizedBox(height: 80),
                Image.asset(
                  'assets/launcher/logo2.png',
                  height: 200,
                ),
                const SizedBox(height: 30),
                Text(
                  LocalizationKeys.enter_phone_number.tr,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(LocalizationKeys.phone_confirmation.tr),
                const SizedBox(
                  height: 20,
                ),
                GetX<LoginViewModel>(
                    init: loginViewModel,
                    builder: (context) => TextField(
                          maxLength: 11,
                          onChanged: (value) =>
                              loginViewModel.errMessage.value = null,
                          textInputAction: TextInputAction.done,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.phone,
                          controller: loginViewModel.phoneController,
                          decoration: InputDecoration(
                            hintText: LocalizationKeys.phone_number_hint.tr,
                            label: Text(LocalizationKeys.phone_number.tr),
                            errorText: loginViewModel.errMessage.value,
                            alignLabelWithHint: true,
                            prefixIcon: const Icon(Icons.phone_android),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.deepPurple)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.deepPurple)),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        )),
                const SizedBox(height: 30),
                SignInButtonBuilder(
                  text: LocalizationKeys.app_login.tr,
                  textColor: Colors.white,
                  icon: Icons.phone_android,
                  iconColor: Colors.white,
                  backgroundColor: Colors.deepPurple,
                  onPressed: () {
                    phoneSignInOnPressed();
                  },
                  height: 50,
                  elevation: 2,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  splashColor: Colors.white30,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "--------------------",
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                      Text(
                        " ${LocalizationKeys.or.tr} ",
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text("--------------------",
                          style:
                              TextStyle(fontSize: 20, color: Colors.black54)),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: SignInButton(Buttons.FacebookNew,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      text: LocalizationKeys.login_facebook.tr,
                      onPressed: () {}),
                ),
                SignInButton(Buttons.Google,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    text: LocalizationKeys.login_google.tr,
                    onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  phoneSignInOnPressed() {
    if (loginViewModel.validatePhone() == null) {
      loginViewModel.loginWithPhone();
    }
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
