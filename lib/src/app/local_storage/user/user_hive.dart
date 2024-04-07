import 'package:hive/hive.dart';

import 'user_model.dart';

class UserHive {
  final _userBox = Hive.box('user');

  Box get userBox => _userBox;

  void saveLocalUser({required String username, required String email}) {
    _userBox.put('username', username);
    _userBox.put('email', email);
  }

  void deleteLocalUser() {
    _userBox.delete('username');
    _userBox.delete('email');
  }

  String getLocalUsername() {
    return _userBox.get('username');
  }

  String getLocalEmail() {
    return _userBox.get('email');
  }

  LocalUserModel getLocalUser() {
    return LocalUserModel(
      username: _userBox.get('username'),
      email: _userBox.get('email'),
    );
  }
}
