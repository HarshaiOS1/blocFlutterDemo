import 'package:meta/meta.dart';

class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    if (username.isEmpty || password.isEmpty) {
      return '';
    } else {
      return 'TOKEN';
    }
  }

  Future<String> registerUser({
    @required String name,
    @required String mailId,
    @required String phoneNumber,
    @required String password,
    @required String confirmPassword,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    if (name.isEmpty || mailId.isEmpty || phoneNumber.isEmpty
        || (password != confirmPassword) || confirmPassword.isEmpty) {
      return '';
    } else {
      return 'NEW TOKEN';
    }
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
