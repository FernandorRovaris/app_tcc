import 'dart:convert';
import 'dart:io';

import 'package:app_tcc/Utils/utils.dart';
import 'package:app_tcc/controllers/campanha_controller.dart';
import 'package:app_tcc/custom_exeption/api_exeption.dart';
import 'package:app_tcc/models/campanhas_model.dart';
import 'package:app_tcc/models/fotos_model.dart';
import 'package:app_tcc/models/user_model.dart';
import 'package:app_tcc/repositories/campanha_repository.dart';
import 'package:app_tcc/service/dio_api_service.dart';
import 'package:app_tcc/widgets/custom_text_field.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CadCampanhas extends StatefulWidget {
  const CadCampanhas({super.key});

  @override
  State<CadCampanhas> createState() => _CadCampanhasState();
}

class _CadCampanhasState extends State<CadCampanhas> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController tituloController = TextEditingController();
  TextEditingController itemDescController = TextEditingController();
  TextEditingController itemMedaController = TextEditingController();
  TextEditingController descricaoController = TextEditingController();

  int _currentIndex = 0;

  bool _isColeta = false;
  bool modeInsert = false;

  final imagePicker = ImagePicker();
  final List<File> _images = [];

  int? _indexCategoria;
  final List<String> _categorias = [
    "Móveis",
    "Alimentos",
    "Eletro/Eletrônicos",
    "Saúde",
    "Brinquedos",
    "Vestuário&Calçados",
    "Educação",
    "Outros",
    "Dinheiro",
  ];

  @override
  Widget build(BuildContext context) {
    UserModel userModel =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
          title: const Text("Cadastro de Campanhas",
              style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: SizedBox(
                      height: 280,
                      width: 500,
                      child: Stack(
                        children: [
                          Center(
                            child: CarouselSlider(
                              items: _images.map((e) {
                                return Image.memory(e.readAsBytesSync());
                              }).toList(),
                              options: CarouselOptions(
                                viewportFraction: 1.5,
                                enlargeCenterPage: false,
                                onPageChanged: (index, reason) {
                                  _currentIndex = index;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () {
                                  showOpcoesBottomSheet(
                                    context,
                                    () async {
                                      Navigator.of(context).pop();
                                      // Buscar imagem da galeria
                                      final pickedFile =
                                          await imagePicker.pickImage(
                                              source: ImageSource.gallery);
                                      if (pickedFile != null) {
                                        _images.add(File(pickedFile.path));
                                        setState(() {});
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
                                              _images.add(value),
                                              setState(() {}),
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    () {
                                      Navigator.of(context).pop();
                                      _images.removeAt(_currentIndex);
                                      setState(() {});
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(30, 60),
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                CustomTextField(
                  controller: tituloController,
                  labelText: "Titulo",
                  keyboardType: TextInputType.name,
                  padding: const EdgeInsets.all(8),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Insira o titulo";
                    } else {
                      return null;
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    style: const TextStyle(fontSize: 25, color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: "Categoria",
                      filled: true,
                      labelStyle: TextStyle(color: Colors.black, fontSize: 18),
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
                    value: _indexCategoria,
                    onChanged: (value) {
                      _indexCategoria = value;
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    items: _categorias.map<DropdownMenuItem<int>>((e) {
                      return DropdownMenuItem(
                          value: _categorias.indexOf(e), child: Text(e));
                    }).toList(),
                  ),
                ),
                CustomTextField(
                  controller: itemDescController,
                  labelText: "Descrição do Itens",
                  keyboardType: TextInputType.name,
                  padding: const EdgeInsets.all(8),
                ),
                CustomTextField(
                  controller: itemMedaController,
                  labelText: "Meta (Quantidade de Itens)",
                  keyboardType: TextInputType.name,
                  padding: const EdgeInsets.all(8),
                ),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25.0),
                      child: Text(
                        "Descrição da Campanha",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  controller: descricaoController,
                  labelText: "",
                  keyboardType: TextInputType.text,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  maxLines: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Disponibiliza Coleta",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(Icons.fire_truck_outlined),
                      ),
                      SizedBox(
                        height: 60,
                        width: 80,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Switch(
                            value: _isColeta,
                            onChanged: (value) {
                              _isColeta = value;
                              setState(() {});
                            },
                            activeColor: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(150, 60),
                            backgroundColor:
                                const Color.fromARGB(202, 199, 199, 1000),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            side: const BorderSide(
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          onPressed: () => save(userModel.id!),
                          child: modeInsert
                              ? Container(
                                  width: 25,
                                  height: 25,
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                    strokeWidth: 5,
                                  ),
                                )
                              : const Text(
                                  "Salvar Campanha",
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> save(int usersId) async {
    if (_formKey.currentState!.validate()) {
      CampanhaModel? campanhaModel = CampanhaModel();
      FotosModel? fotos = FotosModel();

      CampanhaController controller =
          CampanhaController(CampanhaRepository(DioApiService()));

      campanhaModel.usersId = usersId;
      campanhaModel.titulo = tituloController.text.trim();
      campanhaModel.categoria = _indexCategoria;
      campanhaModel.itemDesc = itemDescController.text.trim();
      campanhaModel.itemMeta = itemMedaController.text.trim();
      campanhaModel.descricao = descricaoController.text.trim();
      campanhaModel.titulo = tituloController.text.trim();
      campanhaModel.isColeta = _isColeta;

      List<String> imagens = _images.map((e) {
        return base64Encode(e.readAsBytesSync());
      }).toList();

      try {
        setState(() {
          modeInsert = true;
        });

        campanhaModel = await controller.save(campanhaModel);

        fotos.campanhasId = campanhaModel!.id;
        fotos.listFotos = imagens;

        await controller.saveFotos(fotos);

        if (context.mounted) {
          messageAlert(
              "Campanha ${campanhaModel.titulo} cadastrado com Sucesso",
              context);
/*
          Navigator.of(context)
              .pushReplacementNamed('/home', arguments: userModel);*/
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
