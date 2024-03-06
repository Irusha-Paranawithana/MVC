import 'package:assone/model/reset_model.dart';

class ResetPassController {
  final AuthModel _authModel = AuthModel();

  Future<void> resetPassword(String email) async {
    await _authModel.resetPassword(email);
  }
}
