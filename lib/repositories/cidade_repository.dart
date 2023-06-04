import 'package:app_tcc/models/cidade_model.dart';
import 'package:app_tcc/service/dio_api_service.dart';

class CidadeRepository {
  final DioApiService _dioApiService;
  CidadeRepository(this._dioApiService);

  Future<CidadeModel?> getId(int id) async {
    var result = await _dioApiService.getDio().get('/cidades/$id');

    if (result.statusCode == 200) {
      return CidadeModel.fromJson(result.data!);
    } else {
      return null;
    }
  }
}
