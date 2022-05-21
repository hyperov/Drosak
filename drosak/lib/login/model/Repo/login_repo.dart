import 'package:firebase_auth/firebase_auth.dart';

class LoginRepo {
  FirebaseAuth get auth => FirebaseAuth.instance;

  Future<User?> signInWithCredential(AuthCredential credential) async {
    var userCredential = await auth.signInWithCredential(credential);
    return userCredential.user;
  }
}
