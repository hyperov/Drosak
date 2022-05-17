import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginRepo {
  final FirebaseAuth _auth = Get.find();

  get getInstance => _auth;

  Future<User?> signInWithCredential(AuthCredential credential) async {
    var userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
    // insertUser(userCredential.user!);
  }

  insertUser(User user) async {
    // await _auth.updateProfile(
    //   UserUpdateInfo()
    //     ..displayName = user.displayName
    //     ..photoUrl = user.photoUrl
    // );
  }
}
