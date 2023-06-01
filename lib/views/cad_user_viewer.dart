import 'dart:convert';
import 'dart:io';

import 'package:app_tcc/Utils/utils.dart';
import 'package:app_tcc/controllers/estado_controller.dart';
import 'package:app_tcc/controllers/user_controller.dart';
import 'package:app_tcc/custom_exeption/api_exeption.dart';
import 'package:app_tcc/models/cidade_model.dart';
import 'package:app_tcc/models/estados_model.dart';
import 'package:app_tcc/models/user_model.dart';
import 'package:app_tcc/repositories/estado_repository.dart';
import 'package:app_tcc/repositories/user_repository.dart';
import 'package:app_tcc/service/dio_api_service.dart';
import 'package:app_tcc/widgets/custom_text_field.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CadUserViewer extends StatefulWidget {
  const CadUserViewer({super.key});

  @override
  State<CadUserViewer> createState() => _CadUserViewerState();
}

class _CadUserViewerState extends State<CadUserViewer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool modeInsert = false;

  String? volutario = "T";

  int? dropdownEstado;
  int? dropdownCidade;

  final imagePicker = ImagePicker();
  File? imageFile;

  List<EstadoModel>? estados = List<EstadoModel>.empty();

  TextEditingController nomeController = TextEditingController();
  TextEditingController sobreNomeController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confSenhaController = TextEditingController();
  TextEditingController cepController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController enderecoController = TextEditingController();

  Future<List<EstadoModel>?> _getEstados() async {
    EstadoController controller =
        EstadoController(EstadoRepository(DioApiService()));

    estados = await controller.getAll();

    return estados;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Cadastro de Usuario"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder(
          future: _getEstados(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    strokeWidth: 5,
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
                  return _createUser(context, snapshot);
                }
            }
          }),
    );
  }

  Widget _createUser(context, snapshot) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
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
                        radius: 75,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: imageFile == null
                            ? const Icon(
                                Icons.photo_camera_outlined,
                                size: 120,
                                color: Colors.black,
                              )
                            : CircleAvatar(
                                radius: 65,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: imageFile != null
                                    ? FileImage(imageFile!)
                                    : null,
                              ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: IconButton(
                            onPressed: () {
                              showOpcoesBottomSheet(
                                context,
                                () async {
                                  Navigator.of(context).pop();
                                  // Buscar imagem da galeria
                                  final pickedFile = await imagePicker
                                      .pickImage(source: ImageSource.gallery);

                                  if (pickedFile != null) {
                                    setState(() {
                                      imageFile = File(pickedFile.path);
                                    });
                                  }
                                },
                                () {
                                  Navigator.of(context).pop();
                                  // Fazer foto da câmera
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CameraCamera(
                                        onFile: (value) => {
                                          Navigator.pop(context),
                                          imageFile = value,
                                          setState(() {}),
                                        },
                                      ),
                                    ),
                                  );
                                },
                                () {
                                  Navigator.of(context).pop();

                                  imageFile = null;
                                  setState(() {});
                                },
                              );
                            },
                            icon: Icon(
                              PhosphorIcons.regular.pencilSimple,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomTextField(
                controller: nomeController,
                padding: const EdgeInsets.only(top: 15),
                labelText: "Nome",
                prefixIcon: Icons.assignment_ind_outlined,
                keyboardType: TextInputType.name,
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return "Insira seu Nome";
                  } else {
                    return null;
                  }
                }),
              ),
              CustomTextField(
                controller: celularController,
                padding: const EdgeInsets.only(top: 15),
                labelText: "Celular",
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.name,
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return "Insira seu Celular";
                  } else {
                    return null;
                  }
                }),
              ),
              CustomTextField(
                controller: emailController,
                padding: const EdgeInsets.only(top: 15),
                labelText: "Email",
                prefixIcon: Icons.email,
                keyboardType: TextInputType.name,
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return "Insira seu Email";
                  } else {
                    return null;
                  }
                }),
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
                  value: dropdownEstado,
                  onChanged: (newValue) {
                    setState(() {
                      dropdownEstado = newValue!;
                      dropdownCidade = null;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Informe o Estado";
                    } else {
                      return null;
                    }
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  items: snapshot.data
                      .map<DropdownMenuItem<int>>((EstadoModel estado) {
                    return DropdownMenuItem(
                      value: estado.id,
                      child: Text(estado.nome!),
                    );
                  }).toList(),
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
                  value: dropdownCidade,
                  validator: (value) {
                    if (value == null) {
                      return "Informe a Cidade";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (newValue) {
                    dropdownCidade = newValue;
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  items: snapshot.data
                      .firstWhere((estados) => estados.id == dropdownEstado,
                          orElse: () =>
                              EstadoModel(cidades: List<CidadeModel>.empty()))
                      .cidades
                      .map<DropdownMenuItem<int>>((CidadeModel cidade) {
                    return DropdownMenuItem(
                      value: cidade.id,
                      child: Text(cidade.nome!),
                    );
                  }).toList(),
                ),
              ),
              CustomTextField(
                controller: cepController,
                prefixIcon: Icons.numbers_outlined,
                padding: const EdgeInsets.only(top: 15),
                labelText: "Cep",
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
                controller: numeroController,
                prefixIcon: Icons.exposure_zero_outlined,
                padding: const EdgeInsets.only(top: 15),
                labelText: "Numero",
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
                controller: enderecoController,
                prefixIcon: Icons.home_outlined,
                padding: const EdgeInsets.only(top: 15),
                labelText: "Endereço",
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
                controller: senhaController,
                padding: const EdgeInsets.only(top: 15),
                labelText: "Senha",
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.name,
                obscureText: true,
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return "Insira seu Senha";
                  } else if (value != confSenhaController.text) {
                    return "Senhas não Conferen";
                  } else {
                    return null;
                  }
                }),
              ),
              CustomTextField(
                controller: confSenhaController,
                padding: const EdgeInsets.only(top: 15),
                labelText: "Confirma Senha",
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.name,
                obscureText: true,
                validator: ((value) {
                  if (value == null || value.isEmpty) {
                    return "Confirme sua Senha";
                  } else if (value != senhaController.text) {
                    return "Senhas não Conferen";
                  } else {
                    return null;
                  }
                }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(202, 199, 199, 1000),
                    border: Border.all(width: 1)),
                child: Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        activeColor: Colors.black,
                        title: const Text(
                          "Voluntário",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        value: "T",
                        groupValue: volutario,
                        onChanged: (value) {
                          setState(() {
                            volutario = value;
                          });
                        },
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
                        groupValue: volutario,
                        onChanged: (value) {
                          setState(() {
                            volutario = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
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
                  onPressed: modeInsert ? null : saveUser,
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
                          "Continuar",
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

  Future<void> saveUser() async {
    if (_formKey.currentState!.validate()) {
      UserModel? userModel = UserModel();

      UserController controller =
          UserController(UserRepository(DioApiService()));

      userModel.nome = nomeController.text.trim();
      userModel.sobreNome = sobreNomeController.text.trim();
      userModel.email = emailController.text.trim().toLowerCase();
      userModel.celular = celularController.text.trim();
      userModel.senha = senhaController.text.trim();
      userModel.isInstituicao = volutario == "F";
      userModel.estadoId = dropdownEstado;
      userModel.cidadeId = dropdownCidade;
      userModel.cep = cepController.text.trim();
      userModel.numero = numeroController.text.trim();
      userModel.endereco = enderecoController.text.trim();

      if (imageFile != null && await imageFile!.exists()) {
        List<int> imageBytes = imageFile!.readAsBytesSync();
        userModel.fileImage = base64Encode(imageBytes);
      } else {
        userModel.fileImage = null;
      }

      try {
        setState(() {
          modeInsert = true;
        });

        userModel = await controller.saveUser(userModel);

        if (mounted) {
          messageAlert(
              "Usuario ${userModel!.nome} cadastrado com Sucesso", context);
          Navigator.pushReplacementNamed(context, '/home',
              arguments: userModel);
        }
      } on ApiExeption catch (e) {
        messageAlert(e.message, context);
      } finally {
        setState(() {
          modeInsert = false;
        });
      }
    }
  }
}
