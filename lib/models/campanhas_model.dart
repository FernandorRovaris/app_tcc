import 'package:app_tcc/models/fotos_model.dart';

class CampanhaModel {
  int? id;
  int? usersId;
  String? titulo;
  int? categoria;
  String? itemDesc;
  String? itemMeta;
  String? descricao;
  bool? isColeta;
  List<FotosModel>? fotos;

  CampanhaModel({
    this.id,
    this.usersId,
    this.titulo,
    this.categoria,
    this.itemDesc,
    this.itemMeta,
    this.descricao,
    this.isColeta,
    this.fotos,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['users_id'] = usersId;
    data['titulo'] = titulo;
    data['categoria'] = categoria;
    data['item_desc'] = itemDesc;
    data['item_meta'] = itemMeta;
    data['descricao'] = descricao;
    data['is_coleta'] = isColeta;
    data['fotos'] = fotos;

    return data;
  }

  factory CampanhaModel.fromMap(Map<String, dynamic> map) {
    return CampanhaModel(
      id: map['id'] ?? '',
      usersId: map['users_id'] ?? '',
      titulo: map['titulo'] ?? '',
      categoria: map['categoria'] ?? '',
      itemDesc: map['item_desc'] ?? '',
      itemMeta: map['item_meta'] ?? '',
      descricao: map['descricao'] ?? '',
      isColeta: map['is_coleta'],
      fotos: map["listFotos"].map<FotosModel>((obj) {
        return FotosModel(
          id: obj['id'],
          campanhasId: obj['campanhaId'],
          foto: obj['foto'],
        );
      }).toList(),
    );
  }
}
