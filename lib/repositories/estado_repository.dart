import 'package:app_tcc/models/cidade_model.dart';
import 'package:app_tcc/models/estados_model.dart';
import 'package:app_tcc/service/dio_api_service.dart';

class EstadoRepository {
  final DioApiService _dioApiService;
  EstadoRepository(this._dioApiService);

  Future<List<EstadoModel>> getAll() async {
    List<EstadoModel> estados = [];

    var result = await _dioApiService.getDio().get("/estados");

    for (Map estado in result.data) {
      List<CidadeModel> cidades = [];

      for (var cidade in estado["listCidade"]) {
        CidadeModel cidadeModel = CidadeModel(
          id: cidade["id"],
          nome: cidade["nome"],
        );
        cidades.add(cidadeModel);
      }
      EstadoModel estadoModel = EstadoModel(
        id: estado["id"],
        nome: estado["nome"],
        cidades: cidades,
      );

      estados.add(estadoModel);
    }

    return estados;
  }
}
