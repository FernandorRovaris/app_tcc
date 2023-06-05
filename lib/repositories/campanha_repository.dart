import 'package:app_tcc/models/campanhas_model.dart';
import 'package:app_tcc/models/fotos_model.dart';
import 'package:app_tcc/service/dio_api_service.dart';

class CampanhaRepository {
  final DioApiService _dioApiService;
  CampanhaRepository(this._dioApiService);

  Future<CampanhaModel?> save(CampanhaModel campanhaModel) async {
    var result = await _dioApiService.getDio().post(
          "/campanha",
          data: campanhaModel.toJson(),
        );

    if (result.statusCode == 200) {
      return CampanhaModel.fromMap(result.data!);
    } else {
      return null;
    }
  }

  Future<void> saveFoto(FotosModel fotos) async {
    await _dioApiService.getDio().post(
          "/campanha/${fotos.campanhasId.toString()}/fotos",
          data: fotos.toJson(),
        );
  }
}
