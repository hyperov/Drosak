import 'package:drosak/common/viewmodel/filter_viewmodel.dart';
import 'package:drosak/home/HomeViewModel.dart';
import 'package:drosak/home/home_screen.dart';
import 'package:drosak/profile/view/personal_profile_screen.dart';
import 'package:drosak/utils/storage_keys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'view/login_phone_or_social_screen.dart';

class IsLoginWidget extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  IsLoginWidget({Key? key}) : super(key: key);
  final _storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      initialData: _auth.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return PhoneOrSocialLoginScreen();
        }

        var isFirstTimeLogin =
            _storage.read<bool>(StorageKeys.isFirstTimeLogin);

        if (isFirstTimeLogin == null || isFirstTimeLogin == false) {
          Get.lazyPut<HomeViewModel>(() => HomeViewModel(), fenix: true);
          Get.lazyPut<FilterViewModel>(() => FilterViewModel(), fenix: true);
          return HomeScreen();
        }

        return PersonalProfileScreen();
      },
    );
  }
}
