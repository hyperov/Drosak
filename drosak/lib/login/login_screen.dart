import 'package:drosak/login/login_view_model.dart';
import 'package:drosak/utils/localization_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final LoginViewModel loginViewModel = Get.put(LoginViewModel());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFFFFC2C0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            child: Column(
              children: [
                SizedBox(height: 80),
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
                  maxLength: 11,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.phone,
                  controller: loginViewModel.phoneController,
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
                  textColor: Colors.white,
                  icon: Icons.phone_android,
                  iconColor: Colors.white,
                  backgroundColor: Colors.deepPurple,
                  onPressed: () {},
                  height: 50,
                  elevation: 2,
                  padding: EdgeInsets.all(10),
                  splashColor: Colors.white30,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Text("--------------------------",style: TextStyle(fontSize: 20,color: Colors.black54),)),
                      Text("  ${LocalizationKeys.or.tr}  ",style: TextStyle(fontSize: 20,),),
                      Expanded(
                          child: Text("---------------------------",style: TextStyle(fontSize: 20,color: Colors.black54))),
                    ],
                  ),
                ),
                Container(margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: SignInButton(Buttons.FacebookNew,
                      padding: EdgeInsets.all(12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      text: LocalizationKeys.login_facebook.tr,
                      onPressed: () {}),
                ),
                SignInButton(Buttons.Google,
                    padding: EdgeInsets.only(left: 12, right: 12, top: 7, bottom: 7),
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

  error(String message) => Get.snackbar(message, '',
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2));

  success(String message) => Get.snackbar(message, '',
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2));
}
