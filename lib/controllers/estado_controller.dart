import 'package:app_tcc/custom_exeption/api_exeption.dart';
import 'package:app_tcc/models/estados_model.dart';
import 'package:app_tcc/repositories/estado_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class EstadoController {
  final EstadoRepository _estadoRepository;

  EstadoController(this._estadoRepository);

  ValueNotifier<EstadoModel?> estado = ValueNotifier(null);

  Future<List<EstadoModel>> getAll() async {
    try {
      return await _estadoRepository.getAll();
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
