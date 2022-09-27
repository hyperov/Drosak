import 'package:drosak/login/viewmodel/login_view_model.dart';
import 'package:drosak/profile/view/personal_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'view/login_phone_or_social_screen.dart';

class IsLoginWidget extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  IsLoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginViewModel _loginViewModel = Get.put(LoginViewModel());

    // ever(_loginViewModel.isLoggedIn, (callback) async {
    //   var isFirstTimeUserLogin =
    //       _storage.read<bool>(StorageKeys.isFirstTimeLogin);
    //
    //   if (isFirstTimeUserLogin!) {
    //     Get.offAll(() => PersonalProfileScreen());
    //   } else {
    //     Get.offAll(() => HomeScreen(), binding: HomeBindings());
    //   }
    //   EasyLoading.showSuccess("You are logged in");
    //   FirebaseCrashlytics.instance
    //       .setUserIdentifier(FirebaseAuth.instance.currentUser!.uid);
    // }, condition: () => _loginViewModel.isLoggedIn.value);

    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      initialData: _auth.currentUser,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return PhoneOrSocialLoginScreen();
        }

        //facebook login and google login if first time login
        _loginViewModel
            .loginUserToFireStore(snapshot.data!)
            .then((value) => null);

        // var isFirstTimeLogin =
        //     _storage.read<bool>(StorageKeys.isFirstTimeLogin);

        // if (isFirstTimeLogin == null || isFirstTimeLogin == false) {
        //   Get.lazyPut<HomeViewModel>(() => HomeViewModel(), fenix: true);
        //   Get.lazyPut<FilterViewModel>(() => FilterViewModel(), fenix: true);

        // _userRepo.updateUserLoginStatus(snapshot.data!).then((value) async {
        //   await _storage.write(StorageKeys.studentId, snapshot.data!.uid);
        // });
        // return HomeScreen();
        return Container(
          color: Colors.deepPurple,
        );
        // }

        return PersonalProfileScreen();
      },
    );
  }
}
