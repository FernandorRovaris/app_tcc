import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class UserModel {
  int? id;
  String? nome;
  String? sobreNome;
  String? email;
  String? senha;
  String? celular;
  int? estadoId;
  int? cidadeId;
  String? cep;
  String? numero;
  String? endereco;
  String? fileImage;
  MemoryImage? image;
  bool? isInstituicao;

  UserModel(
      {this.id,
      this.nome,
      this.sobreNome,
      this.email,
      this.senha,
      this.celular,
      this.estadoId,
      this.cidadeId,
      this.cep,
      this.endereco,
      this.numero,
      this.fileImage,
      this.image,
      this.isInstituicao});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['sobrenome'] = sobreNome;
    data['email'] = email;
    data['senha'] = senha;
    data['celular'] = celular;
    data['estadoId'] = estadoId;
    data['cidadeId'] = cidadeId;
    data['cep'] = cep;
    data['numero'] = numero;
    data['endereco'] = endereco;
    data['isInstituicao'] = isInstituicao;
    data['fileImage'] = fileImage;
    return data;
  }

  @override
  String toString() {
    return "id = $id"
        "Nome = $nome"
        "email = $email"
        "senha = $senha"
        "celular = $celular";
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    late List<int>? imageBytes = List.empty();

    if (map["fileImage"] != null) {
      imageBytes = base64Decode(map["fileImage"]);
    }
    return UserModel(
        id: map['id'] ?? '',
        nome: map['nome'] ?? '',
        sobreNome: map['sobrenome'] ?? '',
        email: map['email'] ?? '',
        celular: map['celular'] ?? '',
        estadoId: map['estadoId'],
        cidadeId: map['cidadeId'],
        cep: map['cep'] ?? '',
        numero: map['numero'] ?? '',
        endereco: map['endereco'] ?? '',
        isInstituicao: map['isInstituicao'] ?? '',
        image: imageBytes.isNotEmpty
            ? MemoryImage(
                Uint8List.fromList(imageBytes),
                scale: 0.5,
              )
            : null);
  }
}
