import 'dart:convert';

import 'package:app_tcc/controllers/campanha_controller.dart';
import 'package:app_tcc/models/campanhas_model.dart';
import 'package:app_tcc/repositories/campanha_repository.dart';
import 'package:app_tcc/service/dio_api_service.dart';
import 'package:app_tcc/views/doarse_viewer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TimeLineHome extends StatefulWidget {
  const TimeLineHome({super.key});

  @override
  State<TimeLineHome> createState() => _TimeLineHomeState();
}

class _TimeLineHomeState extends State<TimeLineHome> {
  Future<List<CampanhaModel>?> getCampanhas() async {
    CampanhaController controller =
        CampanhaController(CampanhaRepository(DioApiService()));

    return await controller.getAll(null);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                  valueColor: AlwaysStoppedAnimation(Colors.grey),
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
      future: getCampanhas(),
    );
  }

  Widget _tela(BuildContext context, AsyncSnapshot snapshot) {
    return ListView(
      children: snapshot.data.map<Widget>((campanhas) {
        return Card(
          elevation: 80,
          margin: const EdgeInsets.all(8),
          color: Theme.of(context).primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                  Text(
                    campanhas.user.nome,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CarouselSlider(
                      items: campanhas.fotos.map<Widget>((fotosModel) {
                        return Image.memory(base64Decode(fotosModel.foto));
                      }).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Campanha",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            campanhas.titulo,
                            style: const TextStyle(fontSize: 50),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 60),
                          padding: const EdgeInsets.all(18),
                          backgroundColor:
                              const Color.fromARGB(202, 199, 199, 1000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: const BorderSide(
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DorseViewer(
                                campanhaModel: campanhas,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "DOAR-SE",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
