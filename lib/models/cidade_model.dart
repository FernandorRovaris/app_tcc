import 'package:app_tcc/models/estados_model.dart';

class CidadeModel {
  int? id;
  String? nome;
  EstadoModel? estadoModel;

  CidadeModel({
    this.id,
    this.nome,
    this.estadoModel,
  });

  CidadeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    nome = json['nome'] ?? '';
    estadoModel = EstadoModel.fromJson(json["estado"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    return data;
  }

  @override
  String toString() {
    return " id = $id"
        " Nome = $nome";
  }
}
