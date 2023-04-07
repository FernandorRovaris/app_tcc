import 'dart:developer';

import 'package:app_tcc/service/dio_api_service.dart';

import '../models/user_model.dart';

class UserRepository {
  final DioApiService _dioApiService;
  UserRepository(this._dioApiService);

  Future<UserModel> getUserId(int id) async {
    log("$id");

    var result = await _dioApiService.getDio().get("/users/$id");

    return UserModel.fromJson(result.data);
  }
}
