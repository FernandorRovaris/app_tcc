import 'package:app_tcc/service/dio_api_service.dart';

import '../models/user_model.dart';

class UserRepository {
  final DioApiService _dioApiService;
  UserRepository(this._dioApiService);

  Future<UserModel> getUserId(int id) async {
    var result = await _dioApiService.getDio().get("/users/$id");

    return UserModel.fromJson(result.data);
  }

  Future<UserModel?> saveUser(UserModel userModel) async {
    var result = await _dioApiService.getDio().post(
          "/users",
          data: userModel.toJson(),
        );

    if (result.statusCode == 200) {
      return UserModel.fromJson(result.data!);
    } else {
      return null;
    }
  }

  Future<UserModel?> authUser(String email, String senha) async {
    var result = await _dioApiService.getDio().get(
      "/auth",
      queryParameters: {"email": email, "senha": senha},
    );

    if (result.statusCode == 200) {
      return UserModel.fromJson(result.data!);
    } else {
      return null;
    }
  }
}
