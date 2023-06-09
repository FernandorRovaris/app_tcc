class FotosModel {
  int? id;
  int? campanhasId;
  List<String>? listFotos;
  String? foto;

  FotosModel({
    this.id,
    this.campanhasId,
    this.listFotos,
    this.foto,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fotos'] = listFotos;

    return data;
  }

  factory FotosModel.fromMap(Map<String, dynamic> map) {
    return FotosModel(
      id: map['id'] ?? '',
      campanhasId: map['campanhaId'] ?? '',
      listFotos: map['fotos'],
      foto: map['foto'],
    );
  }
}
