import 'package:app_tcc/models/cidade_model.dart';

class EstadoModel {
  int? id;
  String? nome;
  List<CidadeModel>? cidades;

  EstadoModel({
    this.id,
    this.nome,
    this.cidades,
  });

  List<CidadeModel>? get cidade => cidades;

  EstadoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    nome = json['nome'] ?? '';
    cidades = json["cidades"] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['cidades'] = cidades;
    return data;
  }

  @override
  String toString() {
    return " id = $id"
        " Nome = $nome"
        " Cidades = $cidades";
  }
}
