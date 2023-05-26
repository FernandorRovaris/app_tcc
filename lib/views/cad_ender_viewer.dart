import 'package:app_tcc/models/user_model.dart';
import 'package:app_tcc/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class EnderecoCadastro extends StatefulWidget {
  const EnderecoCadastro({super.key});

  @override
  State<EnderecoCadastro> createState() => _EnderecoCadastroState();
}

class _EnderecoCadastroState extends State<EnderecoCadastro> {
  int? dropdownValue;
  int? newValue;
  late UserModel userModel;

  bool modeInsert = false;

  TextEditingController cidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text('Cadastro de Endereço'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: DropdownButtonFormField(
                  style: const TextStyle(fontSize: 25, color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Estado",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Color.fromARGB(202, 199, 199, 1000),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(80),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(80),
                      ),
                    ),
                  ),
                  dropdownColor: const Color.fromARGB(202, 199, 199, 1000),
                  value: dropdownValue,
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  items: [
                    {"id": 1, "nome": "Morro da fumaça"},
                    {"id": 2, "nome": "Cocal do Sul"}
                  ].map<DropdownMenuItem>((e) {
                    return DropdownMenuItem(
                      value: e['id'],
                      child: Text(e['nome'].toString()),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: DropdownButtonFormField(
                  style: const TextStyle(fontSize: 25, color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: "Estado",
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Color.fromARGB(202, 199, 199, 1000),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(80),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(80),
                      ),
                    ),
                  ),
                  dropdownColor: const Color.fromARGB(202, 199, 199, 1000),
                  value: dropdownValue,
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  items: [
                    {"id": 1, "nome": "Morro da fumaça"},
                    {"id": 2, "nome": "Cocal do Sul"}
                  ].map<DropdownMenuItem>((e) {
                    return DropdownMenuItem(
                      value: e['id'],
                      child: Text(e['nome'].toString()),
                    );
                  }).toList(),
                ),
              ),
              CustomTextField(
                controller: cepController,
                padding: const EdgeInsets.only(top: 20),
                labelText: "Cep",
                //prefixIcon: Icons.assignment_ind_outlined,
                keyboardType: TextInputType.number,
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return "Insira seu Cep";
                  } else {
                    return null;
                  }
                }),
              ),
              CustomTextField(
                controller: cepController,
                padding: const EdgeInsets.only(top: 20),
                labelText: "Numero",
                //prefixIcon: Icons.assignment_ind_outlined,
                keyboardType: TextInputType.number,
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return "Insira seu Cep";
                  } else {
                    return null;
                  }
                }),
              ),
              CustomTextField(
                controller: cepController,
                padding: const EdgeInsets.only(top: 20),
                labelText: "Endereço",
                //prefixIcon: Icons.assignment_ind_outlined,
                keyboardType: TextInputType.number,
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return "Insira seu Cep";
                  } else {
                    return null;
                  }
                }),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(top: 20, right: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 60),
                    padding: const EdgeInsets.all(18),
                    backgroundColor: const Color.fromARGB(202, 199, 199, 1000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    side: const BorderSide(
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  ),
                  onPressed: modeInsert
                      ? null
                      : () {
                          print(userModel);
                        },
                  child: modeInsert
                      ? Container(
                          width: 25,
                          height: 25,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 5,
                          ),
                        )
                      : const Text(
                          "Concluir",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
