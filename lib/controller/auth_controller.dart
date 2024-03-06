import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      print('Error signing in: $e');
      return false;
    }
  }
}
