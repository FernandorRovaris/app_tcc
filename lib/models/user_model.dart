class UserModel {
  int? id;
  String? name;
  String? email;
  String? senha;
  String? dateRegister;
  String? numberCel;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.senha,
      this.dateRegister,
      this.numberCel});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    senha = json['senha'];
    dateRegister = json['date_register'];
    numberCel = json['number_cel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['senha'] = senha;
    data['date_register'] = dateRegister;
    data['number_cel'] = numberCel;
    return data;
  }

  @override
  String toString() {
    return "id = $id"
        "Name = $name"
        "email = $email"
        "senha = $senha"
        "date_register = $dateRegister"
        "number_cel = $numberCel";
  }
}
