import 'package:drosak/login/Repo/login_repo.dart';
import 'package:drosak/utils/localization_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  final LoginRepo _loginRepository = Get.put(LoginRepo());

  RxString verificationId = "".obs;
  //
  final errMessage = RxnString();
  RxBool errorSnackBarShow = false.obs;

  RxString phoneNumber = "".obs;

  RxBool isCodeSent = false.obs;
  RxString smsCode = "".obs;

  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;

  final phoneController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    isLoading.value = false;
    isLoggedIn.value = false;
  }

  loginWithPhone() async {
    isLoading.value = true;
    await _loginRepository.getInstance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        try {
          var user = await _loginRepository.getInstance
              .signInWithCredential(credential);

          _loginRepository.insertUser(user);
          isLoggedIn.value = true;
        } on FirebaseAuthException catch (e) {
          if (kDebugMode) {
            print(e);
          }
          errMessage.value = e.message!;
          errorSnackBarShow.value = true;
        }
        isLoading.value = false;
      },
      verificationFailed: (FirebaseAuthException e) {
        isLoading.value = false;
        // ERROR
        if (e.code == 'invalid-phone-number') {
          printError(info: 'The provided phone number is not valid.');
        }
        if (e.code == 'missing-phone-number') {
          printError(info: 'The phone number is missing.');
        }
        if (e.code == 'quota-exceeded') {
          printError(info: 'The project exceeds a quota.');
        }
        if (e.code == 'cancelled-verification') {
          printError(info: 'The verification was cancelled.');
        }
        if (e.code == 'invalid-verification-code') {
          printError(info: 'The verification code is invalid.');
        }
        if (e.code == 'invalid-verification-id') {
          printError(info: 'The verification ID is invalid.');
        }
        if (e.code == 'missing-verification-code') {
          printError(info: 'The verification code is missing.');
        }
        if (e.code == 'missing-verification-id') {
          printError(info: 'The verification ID is missing.');
        }
        if (e.code == 'network-error') {
          printError(info: 'There was a network error.');
        }
        if (e.code == 'session-expired') {
          printError(info: 'The session expired.');
        }
        if (e.code == 'phone-number-already-exists') {
          printError(info: 'The phone number already exists.');
        }
        if (e.code == 'phone format is incorrect') {
          printError(info: 'The phone number session is invalid.');
          errMessage.value = 'The phone number session is invalid.';
        }
        // Handle other errors
        errMessage.value = e.message!;
        errorSnackBarShow.value = true;
      },
      codeSent: (String verificationId, int? resendToken) async {
        //resendToken is only supported on Android devices,
        // iOS devices will always return a null value
        errMessage.value = null;
        this.verificationId.value = verificationId;
        if (kDebugMode) {
          print("code sent in sms");
        }
        // The SMS code has been sent to the provided phone number, we
        // now need to let the user enter the code from the UI.
        isLoading.value = false;
        isCodeSent.value = true;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  sendSmsAndLogin() async {
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value, smsCode: smsCode.value);

    // Sign the user in (or link) with the credential
    await _loginRepository.signInWithCredential(credential);
  }

  String? validatePhone() {
    var phone = phoneController.text;
    if (phone.isEmpty) {
      errMessage.value = LocalizationKeys.phone_number_error_empty.tr;
      errorSnackBarShow.value = true;
      return LocalizationKeys.phone_number_error_empty.tr;
    }
    if (phone.length != 11) {
      errMessage.value = LocalizationKeys.phone_number_error_length.tr;
      errorSnackBarShow.value = true;
      return LocalizationKeys.phone_number_error_length.tr;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      errMessage.value = LocalizationKeys.phone_number_error_format.tr;
      errorSnackBarShow.value = true;
      return LocalizationKeys.phone_number_error_format.tr;
    }
    errMessage.value = null;
    errorSnackBarShow = true.obs;
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }
}
