import 'package:drosak/login/Repo/login_repo.dart';
import 'package:drosak/login/Repo/user_repo.dart';
import 'package:drosak/utils/localization_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginViewModel extends GetxController {
  final LoginRepo _loginRepository = Get.put(LoginRepo());
  final UserRepo _userRepo = Get.put(UserRepo());

  RxString verificationId = "".obs;

  //
  final errMessagePhoneTextField = RxnString();
  final errMessageSnackBar = "".obs;
  RxBool errorSnackBarShow = false.obs;

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
    var phoneNumber = phoneController.text;
    await _loginRepository.getInstance.verifyPhoneNumber(
      phoneNumber: "+2 $phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
        printInfo(info: "firebase auth verify completed");
        try {
          var user = await _loginRepository.getInstance
              .signInWithCredential(credential);

          _userRepo.insertUser(user);
          isLoggedIn.value = true;
        } on FirebaseAuthException catch (e) {
          if (kDebugMode) {
            print(e);
          }
          errMessagePhoneTextField.value = e.message!;
          errMessageSnackBar.value = e.message!;
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
          errMessagePhoneTextField.value =
              'The phone number session is invalid.';
        }
        // Handle other errors
        errorSnackBarShow.value = true;
        errMessagePhoneTextField.value = e.message!;
        errMessageSnackBar.value = e.message!;
      },
      codeSent: (String verificationId, int? resendToken) async {
        //resendToken is only supported on Android devices,
        // iOS devices will always return a null value
        errMessagePhoneTextField.value = null;
        errMessageSnackBar.value = "";
        this.verificationId.value = verificationId;
        if (kDebugMode) {
          printInfo(info: "code sent in sms");
        }
        // The SMS code has been sent to the provided phone number, we
        // now need to let the user enter the code from the UI.
        isLoading.value = false;
        isCodeSent.value = true;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  String? validatePhone() {
    var phone = phoneController.text;
    if (phone.isEmpty) {
      errMessagePhoneTextField.value =
          LocalizationKeys.phone_number_error_empty.tr;
      errMessageSnackBar.value = LocalizationKeys.phone_number_error_empty.tr;
      errorSnackBarShow.value = true;
      return LocalizationKeys.phone_number_error_empty.tr;
    }
    if (phone.length != 11) {
      errMessagePhoneTextField.value =
          LocalizationKeys.phone_number_error_length.tr;
      errMessageSnackBar.value = LocalizationKeys.phone_number_error_length.tr;
      errorSnackBarShow.value = true;
      return LocalizationKeys.phone_number_error_length.tr;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      errMessagePhoneTextField.value =
          LocalizationKeys.phone_number_error_format.tr;
      errMessageSnackBar.value = LocalizationKeys.phone_number_error_format.tr;
      errorSnackBarShow.value = true;
      return LocalizationKeys.phone_number_error_format.tr;
    }
    errMessagePhoneTextField.value = null;
    errMessageSnackBar.value = "";
    errorSnackBarShow = false.obs;
    return null;
  }

  sendSmsAndLogin() async {
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value, smsCode: smsCode.value);

    // Sign the user in (or link) with the credential
    var user = await _loginRepository.signInWithCredential(credential);

    _userRepo.insertUser(user!).then((value) {
      isLoggedIn.value = true;

      if (kDebugMode) {
        printInfo(info: "user logged in");
      }
    }).onError((error, stackTrace) {
      printError(info: "insert user firestore error");
      errMessageSnackBar.value = LocalizationKeys.login_error.tr;
      errorSnackBarShow.value = true;
    });
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try {
      // Once signed in, return the UserCredential
      var user =
          await _loginRepository.getInstance.signInWithCredential(credential);

      _userRepo.insertUser(user).then((value) {
        isLoggedIn.value = true;
      }).onError((error, stackTrace) {
        printError(info: "insert user firestore error");
        errMessageSnackBar.value = LocalizationKeys.login_error.tr;
        errorSnackBarShow.value = true;
      });
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      errMessagePhoneTextField.value = e.message!;
      errMessageSnackBar.value = e.message!;
      errorSnackBarShow.value = true;
    }
    isLoading.value = false;
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }
}
