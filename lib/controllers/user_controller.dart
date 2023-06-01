import 'package:app_tcc/custom_exeption/api_exeption.dart';
import 'package:app_tcc/models/user_model.dart';
import 'package:app_tcc/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class UserController {
  final UserRepository _userRepository;

  UserController(this._userRepository);

  ValueNotifier<UserModel?> users = ValueNotifier(null);

  Future<UserModel> getUser(int id) async {
    //users.value = await _userRepository.getUserId(id);
    return await _userRepository.getUserId(id);
  }

  Future<UserModel?> saveUser(UserModel userModel) async {
    try {
      return await _userRepository.saveUser(userModel);
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        throw ApiExeption(message: e.response!.data["message"]);
      } else {
        throw Exception("Erro Inesperado");
      }
    } catch (e) {
      throw Exception("Erro Inesperado");
    }
  }

  Future<UserModel?> authUser(String email, String senha) async {
    try {
      UserModel? userModel = await _userRepository.authUser(email, senha);
      return userModel;
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        throw ApiExeption(message: e.response!.data["message"]);
      } else {
        rethrow;
      }
    } catch (e) {
      throw Exception("Erro Inesperado");
    }
  }
}
