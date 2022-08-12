import 'package:drosak/bindings/initial_bindings.dart';
import 'package:drosak/home/home_screen.dart';
import 'package:drosak/login/viewmodel/login_view_model.dart';
import 'package:drosak/profile/view/personal_profile_screen.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../common/viewmodel/network_viewmodel.dart';
import 'enter_sms_code_screen.dart';

class PhoneOrSocialLoginScreen extends StatelessWidget {
  final LoginViewModel _loginViewModel = Get.find();
  final NetworkViewModel _networkViewModel = Get.find();

  final _storage = GetStorage();

  PhoneOrSocialLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ever(_loginViewModel.errorSnackBarShow, (callback) {
      if (_loginViewModel.errMessageSnackBar.value.isNotEmpty) {
        EasyLoading.showError(_loginViewModel.errMessageSnackBar.value);
        _loginViewModel.errorSnackBarShow.value = false;
      }
    }, condition: () => _loginViewModel.errorSnackBarShow.value);

    ever(_loginViewModel.isCodeSent, (callback) {
      Get.to(() => EnterSmsCodeScreen());
      _loginViewModel.isCodeSent.value = false;
    }, condition: () => _loginViewModel.isCodeSent.value);

    ever(_loginViewModel.isLoggedIn, (callback) async {
      var isFirstTimeUserLogin =
          _storage.read<bool>(StorageKeys.isFirstTimeLogin);

      if (isFirstTimeUserLogin!) {
        Get.offAll(() => PersonalProfileScreen());
      } else {
        Get.offAll(() => HomeScreen(), binding: HomeBindings());
      }
      EasyLoading.showSuccess("You are logged in");
    }, condition: () => _loginViewModel.isLoggedIn.value);

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
                    init: _loginViewModel,
                    builder: (context) => TextField(
                          maxLength: 11,
                          onChanged: (value) => _loginViewModel
                              .errMessagePhoneTextField.value = null,
                          textInputAction: TextInputAction.done,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.phone,
                          controller: _loginViewModel.phoneController,
                          decoration: InputDecoration(
                            label: Text(LocalizationKeys.phone_number.tr),
                            hintText: LocalizationKeys.phone_number_hint.tr,
                            errorText:
                                _loginViewModel.errMessagePhoneTextField.value,
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
                    if (_networkViewModel.isConnected.value) {
                      clickPhoneSignInButton();
                    } else {
                      _networkViewModel.showNoInternetConnectionDialog();
                    }
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
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "------",
                      style: TextStyle(fontSize: 20, color: Colors.black54),
                    ),
                    Text(
                      " ${LocalizationKeys.or.tr} ",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    const Text("------",
                        style: TextStyle(fontSize: 20, color: Colors.black54)),
                  ],
                ).marginSymmetric(horizontal: 20),
                Theme(
                  data: ThemeData(
                    fontFamily: 'Roboto',
                  ),
                  child: SignInButton(Buttons.FacebookNew,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      text: LocalizationKeys.login_facebook.tr, onPressed: () {
                    if (_networkViewModel.isConnected.isTrue) {
                      // _networkViewModel.loginWithFacebook();
                      _loginViewModel.signInWithFacebook();
                    } else {
                      _networkViewModel.showNoInternetConnectionDialog();
                    }
                  }).marginSymmetric(vertical: 10, horizontal: 20),
                ),
                SignInButton(Buttons.Google,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    text: LocalizationKeys.login_google.tr, onPressed: () {
                  if (_networkViewModel.isConnected.isTrue) {
                    _loginViewModel.signInWithGoogle();
                  } else {
                    _networkViewModel.showNoInternetConnectionDialog();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  clickPhoneSignInButton() {
    if (_loginViewModel.validatePhone() == null) {
      _loginViewModel.loginWithPhone();
    }
  }

// void showNoInternetConnectionDialog() {
//   if (Get.isSnackbarOpen == false) {
//     Get.snackbar(
//       LocalizationKeys.network_error.tr,
//       LocalizationKeys.network_error_message.tr,
//       icon: const Icon(Icons.signal_wifi_off, color: Colors.white),
//       dismissDirection: DismissDirection.horizontal,
//       backgroundColor: Colors.red,
//       colorText: Colors.white,
//       duration: const Duration(milliseconds: 800),
//     );
//   }
// }
}
