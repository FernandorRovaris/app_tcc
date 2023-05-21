class UserModel {
  int? id;
  String? nome;
  String? sobreNome;
  String? email;
  String? senha;
  String? celular;
  bool? isInstituicao;

  UserModel(
      {this.id,
      this.nome,
      this.sobreNome,
      this.email,
      this.senha,
      this.celular,
      this.isInstituicao});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    sobreNome = json['sobrenome'];
    email = json['email'];
    senha = json['senha'];
    celular = json['celular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    data['sobrenome'] = sobreNome;
    data['email'] = email;
    data['senha'] = senha;
    data['celular'] = celular;
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
    return UserModel(
        id: map['id'] ?? '',
        nome: map['nome'] ?? '',
        sobreNome: map['sobrenome'] ?? '',
        email: map['email'] ?? '',
        celular: map['celular'] ?? '');
  }
}
