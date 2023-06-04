import 'package:app_tcc/custom_exeption/api_exeption.dart';
import 'package:app_tcc/models/cidade_model.dart';
import 'package:app_tcc/models/estados_model.dart';
import 'package:app_tcc/repositories/cidade_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class CidadeController {
  final CidadeRepository _cidadeRepository;

  CidadeController(this._cidadeRepository);

  ValueNotifier<EstadoModel?> cidade = ValueNotifier(null);

  Future<CidadeModel?> getId(int id) async {
    try {
      return await _cidadeRepository.getId(id);
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
