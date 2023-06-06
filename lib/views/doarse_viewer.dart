import 'dart:convert';

import 'package:app_tcc/models/campanhas_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DorseViewer extends StatelessWidget {
  const DorseViewer({super.key, required this.campanhaModel});

  final CampanhaModel campanhaModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doar-se", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      " Institução: ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      campanhaModel.user!.nome!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "        Email: ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      campanhaModel.user!.email!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "     Celular: ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      campanhaModel.user!.celular!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      " Endereco: ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "${campanhaModel.user!.estadoId},${campanhaModel.user!.cidadeId},${campanhaModel.user!.numero},${campanhaModel.user!.endereco}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Campanha: ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      campanhaModel.titulo!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "           Item: ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      campanhaModel.itemDesc!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "          Meta: ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      campanhaModel.itemMeta!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "  Descrição: ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      campanhaModel.descricao!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "        Coleta: ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "${campanhaModel.isColeta! ? "" : " Não "}Disponibilizamos Coleta",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Text(
                      "Fotos da Campanha",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                Card(
                  color: Theme.of(context).primaryColor,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: SizedBox(
                    height: 280,
                    width: 500,
                    child: CarouselSlider(
                      items: campanhaModel.fotos!.map<Widget>((fotosModel) {
                        return Image.memory(base64Decode(fotosModel.foto!));
                      }).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
