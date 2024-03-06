import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:assone/model/user_model.dart';

class RegistrationController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(
      UserModel userModel, String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await postDetailToFirestore(userModel);
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> postDetailToFirestore(UserModel userModel) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    userModel.emailAddress = user!.email;
    userModel.uid = user.uid;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
  }
}
