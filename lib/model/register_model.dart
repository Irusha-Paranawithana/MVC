class UserModel {
  String? emailAddress;
  String? uid;
  String? userName;
  String? residentialAddress;
  String? phoneNumber;
  String? password;

  Map<String, dynamic> toMap() {
    return {
      'emailAddress': emailAddress,
      'uid': uid,
      'userName': userName,
      'residentialAddress': residentialAddress,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}
