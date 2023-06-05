import 'package:app_tcc/custom_exeption/api_exeption.dart';
import 'package:app_tcc/models/campanhas_model.dart';
import 'package:app_tcc/models/fotos_model.dart';
import 'package:app_tcc/models/user_model.dart';
import 'package:app_tcc/repositories/campanha_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class CampanhaController {
  final CampanhaRepository _campanhaRepository;

  CampanhaController(this._campanhaRepository);

  ValueNotifier<UserModel?> users = ValueNotifier(null);

  Future<CampanhaModel?> save(CampanhaModel campanhaModel) async {
    try {
      return await _campanhaRepository.save(campanhaModel);
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

  Future<void> saveFotos(FotosModel foto) async {
    try {
      await _campanhaRepository.saveFoto(foto);
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
}
