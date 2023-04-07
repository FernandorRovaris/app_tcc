import 'package:app_tcc/models/user_model.dart';
import 'package:app_tcc/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';

class UserController {
  final UserRepository _userRepository;

  UserController(this._userRepository);

  ValueNotifier<UserModel?> users = ValueNotifier(null);

  getUser(int id) async {
    users.value = await _userRepository.getUserId(id);
  }
}
