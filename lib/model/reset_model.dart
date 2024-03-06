import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
