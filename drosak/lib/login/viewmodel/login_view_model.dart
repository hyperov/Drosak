import 'package:drosak/bindings/initial_bindings.dart';
import 'package:drosak/home/home_screen.dart';
import 'package:drosak/login/model/Repo/login_repo.dart';
import 'package:drosak/login/model/Repo/user_repo.dart';
import 'package:drosak/profile/view/personal_profile_screen.dart';
import 'package:drosak/utils/localization/localization_keys.dart';
import 'package:drosak/utils/messages/logs.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginViewModel extends GetxController {
  final LoginRepo _loginRepository = Get.put(LoginRepo());
  final UserRepo _userRepo = Get.put(UserRepo());
  final _storage = GetStorage();

  RxString verificationId = "".obs;

  //
  final errMessagePhoneTextField = RxnString();
  final errMessageSnackBar = "".obs;
  RxBool errorSnackBarShow = false.obs;

  RxBool isCodeSent = false.obs;

  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;

  RxInt resendToken = 0.obs;
  RxBool isResend = false.obs;

  final phoneController = TextEditingController();

  final smsCodeControllerFirst = TextEditingController();
  final smsCodeControllerSecond = TextEditingController();
  final smsCodeControllerThird = TextEditingController();
  final smsCodeControllerFourth = TextEditingController();
  final smsCodeControllerFifth = TextEditingController();
  final smsCodeControllerSixth = TextEditingController();

  FocusNode smsCodeFocusNodeFirst = FocusNode();
  FocusNode smsCodeFocusNodeSecond = FocusNode();
  FocusNode smsCodeFocusNodeThird = FocusNode();
  FocusNode smsCodeFocusNodeFourth = FocusNode();
  FocusNode smsCodeFocusNodeFifth = FocusNode();
  FocusNode smsCodeFocusNodeSixth = FocusNode();

  @override
  void onReady() {
    super.onReady();
    ever(isLoggedIn, (callback) async {
      if (isLoggedIn.isTrue) {
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

        var isFirstTimeUserLogin =
            _storage.read<bool>(StorageKeys.isFirstTimeLogin);

        if (isFirstTimeUserLogin!) {
          Get.offAll(() => PersonalProfileScreen());
        } else {
          Get.off(() => HomeScreen(), binding: HomeBindings());
        }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    isLoading.value = false;
    isLoggedIn.value = false;
  }

  loginWithPhone() async {
    isLoading.value = true;
    var phoneNumber = phoneController.text;

    await _loginRepository.auth.verifyPhoneNumber(
      phoneNumber: "+2 $phoneNumber",
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
        printInfo(info: "firebase auth verify completed");

        late User? user;
        try {
          user = await _loginRepository.signInWithCredential(credential);
        } on FirebaseAuthException catch (e) {
          if (kDebugMode) {
            print(e);
          }
          _onSnackBarError("{$Logs.firebase_auth_error_login} ${e.message}",
              LocalizationKeys.login_error.tr);
          return;
        }

        await loginUserToFireStore(user!);
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
        errMessagePhoneTextField.value = e.message!;
        _onSnackBarError("{$Logs.firebase_auth_error_login} ${e.message}",
            LocalizationKeys.login_error.tr);
      },
      codeSent: (String verificationId, int? resendToken) async {
        //resendToken is only supported on Android devices,
        // iOS devices will always return a null value

        //now code is sent to mobile in sms message
        errMessagePhoneTextField.value = null;
        errMessageSnackBar.value = "";
        this.verificationId.value = verificationId;
        this.resendToken.value = resendToken!;
        if (kDebugMode) {
          printInfo(info: "code sent in sms");
        }
        // The SMS code has been sent to the provided phone number, we
        // now need to let the user enter the code from the UI.
        isLoading.value = false;
        isCodeSent.value = true;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      forceResendingToken: resendToken.value,
    );
  }

  Future<void> loginUserToFireStore(User user) async {
    var isFirstTimeLogin =
        user.metadata.creationTime!.compareTo(user.metadata.lastSignInTime!);

    await _storage.write(StorageKeys.isFirstTimeLogin, isFirstTimeLogin == 0);

    if (isFirstTimeLogin == 0) {
      _insertUserToFirestore(user);
    } else {
      _updateUserToFirestore(user);
    }
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
    isLoading.value = true;
    // Create a PhoneAuthCredential with the code
    var smsCode = smsCodeControllerFirst.text +
        smsCodeControllerSecond.text +
        smsCodeControllerThird.text +
        smsCodeControllerFourth.text +
        smsCodeControllerFifth.text +
        smsCodeControllerSixth.text;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value, smsCode: smsCode);

    late User? user;
    try {
      user = await _loginRepository.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      _onSnackBarError("${Logs.log_firebase_auth_error_login} ${e.message}",
          LocalizationKeys.login_error.tr);
      return;
    }

    await loginUserToFireStore(user!);
  }

  signInWithGoogle() async {
    isLoading.value = true;
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

    late User? user;
    try {
      // Once signed in, return the UserCredential
      user = await _loginRepository.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }

      _onSnackBarError("${Logs.log_firebase_auth_error_login} ${e.message}",
          LocalizationKeys.login_error.tr);
      return;
    }

    await loginUserToFireStore(user!);
  }

  signInWithFacebook() async {
    isLoading.value = true;
    final LoginResult result = await FacebookAuth.instance
        .login(loginBehavior: LoginBehavior.nativeWithFallback);

    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      late User? user;
      try {
        // Once signed in, return the UserCredential
        user = await _loginRepository.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        if (kDebugMode) {
          print(e);
        }
        _onSnackBarError("${Logs.log_firebase_auth_error_login} ${e.message}",
            LocalizationKeys.login_error.tr);
        return;
      }

      _insertUserToFirestore(user!);
    } else {
      _onSnackBarError(
          Logs.log_facebook_login_error, LocalizationKeys.login_error.tr);

      if (kDebugMode) {
        print(result.status);
        print(result.message);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();

    smsCodeControllerFirst.dispose();
    smsCodeControllerSecond.dispose();
    smsCodeControllerThird.dispose();
    smsCodeControllerFourth.dispose();
    smsCodeControllerFifth.dispose();
    smsCodeControllerSixth.dispose();

    smsCodeControllerFirst.dispose();
    smsCodeControllerSecond.dispose();
    smsCodeControllerThird.dispose();
    smsCodeControllerFourth.dispose();
    smsCodeControllerFifth.dispose();
    smsCodeControllerSixth.dispose();
  }

  void _onSnackBarError(String errorMessage, String errorMessageSnackBar) {
    printError(info: errorMessage);
    errMessageSnackBar.value = errorMessageSnackBar;
    isLoading.value = false;
    isLoggedIn.value = false;
    errorSnackBarShow.value = true;
  }

  void _insertUserToFirestore(User? user) {
    _userRepo.insertUserFirstTime(user!).then((value) async {
      isLoggedIn.value = true;
      isLoading.value = false;

      await _storage.write(StorageKeys.studentId, user.uid);

      if (kDebugMode) {
        printInfo(info: "user logged in");
      }
    }).onError((error, stackTrace) {
      _onSnackBarError(
          "${Logs.log_firestore_error_insert_user} ${error.toString()}",
          LocalizationKeys.login_error.tr);
    });
  }

  String? validateSmsCode() {
    var smsCode1 = smsCodeControllerFirst.text;
    var smsCode2 = smsCodeControllerSecond.text;
    var smsCode3 = smsCodeControllerThird.text;
    var smsCode4 = smsCodeControllerFourth.text;
    var smsCode5 = smsCodeControllerFifth.text;
    var smsCode6 = smsCodeControllerSixth.text;

    var isAllSmsCodeFieldsEmpty = smsCode1.isEmpty &&
        smsCode2.isEmpty &&
        smsCode3.isEmpty &&
        smsCode4.isEmpty &&
        smsCode5.isEmpty &&
        smsCode6.isEmpty;

    var isAtLeastOneSmsCodeFieldIsEmpty = smsCode1.isEmpty ||
        smsCode2.isEmpty ||
        smsCode3.isEmpty ||
        smsCode4.isEmpty ||
        smsCode5.isEmpty ||
        smsCode6.isEmpty;

    if (isAllSmsCodeFieldsEmpty) {
      _onSnackBarError(
          Logs.log_ui_sms_code_empty, LocalizationKeys.sms_code_empty.tr);
      return Logs.log_ui_sms_code_empty;
    }
    if (isAtLeastOneSmsCodeFieldIsEmpty) {
      _onSnackBarError(
          Logs.sms_code_length, LocalizationKeys.sms_code_length.tr);
      return Logs.sms_code_length;
    }
    return null;
  }

  Future<void> resendSmsCode() async {
    isResend.value = true;
    await loginWithPhone();
  }

  void _updateUserToFirestore(User user) {
    _userRepo.updateUserLoginStatus(user).then((value) async {
      isLoggedIn.value = true;
      isLoading.value = false;

      await _storage.write(StorageKeys.studentId, user.uid);

      if (kDebugMode) {
        printInfo(info: "user logged in");
      }
    }).onError((error, stackTrace) {
      _onSnackBarError(
          "{$Logs.firestore_error_insert_user} ${error.toString()}",
          LocalizationKeys.login_error.tr);
    });
  }
}
