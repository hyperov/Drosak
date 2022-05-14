import 'package:drosak/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {

  final RxBool _isLoading = false.obs;
  final RxBool _isLoggedIn = false.obs;

  bool get isLoading => _isLoading.value;

  bool get isLoggedIn => _isLoggedIn.value;

  void setLoading(bool value) => _isLoading.value = value;

  void setLoggedIn(bool value) => _isLoggedIn.value = value;



  @override
  void onClose() {
    super.onClose();
    _isLoading.value = false;
    _isLoggedIn.value = false;
  }

  logout() {
    _isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }

  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  checkLogin() {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
}
