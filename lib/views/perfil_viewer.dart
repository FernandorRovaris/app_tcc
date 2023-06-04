import 'package:app_tcc/controllers/cidade_controller.dart';
import 'package:app_tcc/models/cidade_model.dart';
import 'package:app_tcc/models/user_model.dart';
import 'package:app_tcc/repositories/cidade_repository.dart';
import 'package:app_tcc/service/dio_api_service.dart';
import 'package:app_tcc/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  late final UserModel userModel;
  CidadeModel? cidadeModel;

  Future<CidadeModel?> _buscacidade() async {
    CidadeController controller =
        CidadeController(CidadeRepository(DioApiService()));

    cidadeModel = await controller.getId(userModel.cidadeId!);

    return cidadeModel;
  }

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: _buscacidade(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(
                child: Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    strokeWidth: 5,
                  ),
                ),
              );

            default:
              if (snapshot.hasError) {
                return Container(
                  color: Colors.red,
                  child: const Center(
                    child: Text("Erro inesperado não me reprove"),
                  ),
                );
              } else {
                return _tela(context, snapshot);
              }
          }
        },
      ),
    );
  }

  Widget _tela(BuildContext context, AsyncSnapshot snapshot) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              alignment: Alignment.center,
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(width: 8),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: userModel.image == null
                        ? const Icon(
                            Icons.photo_camera_outlined,
                            size: 120,
                            color: Colors.black,
                          )
                        : CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: userModel.image,
                          ),
                  ),
                ],
              ),
            ),
          ),
          CustomTextField(
            enabled: false,
            initialValue: userModel.nome,
            padding: const EdgeInsets.only(top: 15),
            labelText: "Nome",
            prefixIcon: Icons.assignment_ind_outlined,
            keyboardType: TextInputType.name,
          ),
          CustomTextField(
            enabled: false,
            initialValue: userModel.celular,
            padding: const EdgeInsets.only(top: 15),
            labelText: "Celular",
            prefixIcon: Icons.phone,
            keyboardType: TextInputType.name,
          ),
          CustomTextField(
            enabled: false,
            initialValue: userModel.email,
            padding: const EdgeInsets.only(top: 15),
            labelText: "Email",
            prefixIcon: Icons.email,
            keyboardType: TextInputType.name,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: DropdownButtonFormField(
              style: const TextStyle(fontSize: 25, color: Colors.black),
              decoration: const InputDecoration(
                labelText: "Estado",
                labelStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(Icons.location_on_outlined),
                filled: true,
                fillColor: Color.fromARGB(202, 199, 199, 1000),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
              dropdownColor: const Color.fromARGB(202, 199, 199, 1000),
              value: snapshot.data.estadoModel.id,
              onChanged: null,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              items: [
                DropdownMenuItem(
                  value: snapshot.data.estadoModel.id,
                  child: Text(snapshot.data.estadoModel.nome),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: DropdownButtonFormField(
                isExpanded: true,
                style: const TextStyle(fontSize: 25, color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Cidade",
                  prefixIcon: Icon(Icons.location_city_outlined),
                  labelStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Color.fromARGB(202, 199, 199, 1000),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
                dropdownColor: const Color.fromARGB(202, 199, 199, 1000),
                value: snapshot.data.id,
                onChanged: null,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                items: [
                  DropdownMenuItem(
                    value: snapshot.data.id,
                    child: Text(snapshot.data.nome),
                  ),
                ]),
          ),
          CustomTextField(
            enabled: false,
            initialValue: userModel.cep,
            prefixIcon: Icons.numbers_outlined,
            padding: const EdgeInsets.only(top: 15),
            labelText: "Cep",
            keyboardType: TextInputType.number,
          ),
          CustomTextField(
            enabled: false,
            initialValue: userModel.numero,
            prefixIcon: Icons.exposure_zero_outlined,
            padding: const EdgeInsets.only(top: 15),
            labelText: "Numero",
            keyboardType: TextInputType.number,
          ),
          CustomTextField(
            enabled: false,
            initialValue: userModel.endereco,
            prefixIcon: Icons.home_outlined,
            padding: const EdgeInsets.only(top: 15),
            labelText: "Endereço",
            keyboardType: TextInputType.number,
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(202, 199, 199, 1000),
                border: Border.all(width: 1)),
            child: Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    activeColor: const Color.fromARGB(255, 53, 52, 52),
                    title: const Text(
                      "Voluntário",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    value: "T",
                    groupValue: userModel.isInstituicao! ? "T" : "F",
                    onChanged: (value) {},
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    activeColor: Colors.black,
                    title: const Text(
                      "Institução",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    value: "F",
                    groupValue: userModel.isInstituicao! ? "T" : "F",
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
