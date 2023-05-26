import 'dart:io';

import 'package:app_tcc/Utils/utils.dart';
import 'package:app_tcc/controllers/user_controller.dart';
import 'package:app_tcc/custom_exeption/api_exeption.dart';
import 'package:app_tcc/models/user_model.dart';
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

  String? gender = "T";

  final imagePicker = ImagePicker();
  File? imageFile;

  TextEditingController nomeController = TextEditingController();
  TextEditingController sobreNomeController = TextEditingController();
  TextEditingController celularController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confSenhaController = TextEditingController();

  pick(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
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
      body: SingleChildScrollView(
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
                              onPressed: _showOpcoesBottomSheet,
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
                  padding: const EdgeInsets.only(top: 20),
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
                  controller: sobreNomeController,
                  padding: const EdgeInsets.only(top: 20),
                  labelText: "Sobrenome",
                  prefixIcon: Icons.assignment_ind_outlined,
                  keyboardType: TextInputType.name,
                  validator: ((value) {
                    if (value == null || value.isEmpty) {
                      return "Insira seu Sobrenome";
                    } else {
                      return null;
                    }
                  }),
                ),
                CustomTextField(
                  controller: celularController,
                  padding: const EdgeInsets.only(top: 20),
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
                  padding: const EdgeInsets.only(top: 20),
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
                CustomTextField(
                  controller: senhaController,
                  padding: const EdgeInsets.only(top: 20),
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
                  padding: const EdgeInsets.only(top: 20),
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
                  margin: const EdgeInsets.only(top: 20),
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
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          value: "T",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
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
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          value: "F",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
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
                      backgroundColor:
                          const Color.fromARGB(202, 199, 199, 1000),
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
      userModel.isInstituicao = gender == "F";
      /*
       *Falta salvar Foto
       *  
      */
      try {
        /*setState(() {
          modeInsert = true;
        });

        userModel = await controller.saveUser(userModel);

        if (mounted) {
          messageAlert(
              "Usuario ${userModel!.nome} cadastrado com Sucesso", context);
          Navigator.pushReplacementNamed(context, '/home');
        }*/

        Navigator.of(context).pushNamed("/endereco", arguments: userModel);
      } on ApiExeption catch (e) {
        messageAlert(e.message, context);
      } finally {
        setState(() {
          modeInsert = false;
        });
      }
    }
  }

  void _showOpcoesBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      PhosphorIcons.regular.image,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Galeria',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Buscar imagem da galeria
                  pick(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      PhosphorIcons.regular.camera,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Câmera',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Fazer foto da câmera
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraCamera(
                        onFile: (value) => {
                          Navigator.pop(context),
                          setState(() {
                            imageFile = value;
                          })
                        },
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      PhosphorIcons.regular.trash,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Remover',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // Tornar a foto null
                  setState(() {
                    imageFile = null;
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
