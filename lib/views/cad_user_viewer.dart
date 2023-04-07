import 'dart:developer';

import 'package:app_tcc/widgets/custom_textField.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CadUserViewer extends StatelessWidget {
  const CadUserViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(202, 199, 199, 1000),
                    border: Border.all(width: 8),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Column(
                    children: [
                      IconButton(
                        padding: EdgeInsets.only(top: 5),
                        iconSize: 150,
                        icon: const Icon(
                          Icons.photo_camera_front_outlined,
                        ),
                        onPressed: () {
                          log("camera");
                        },
                      ),
                      const Text(
                        "Foto",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              const CustomTextField(
                padding: EdgeInsets.only(top: 20),
                labelText: "Nome",
                prefixIcon: Icons.assignment_ind_outlined,
                keyboardType: TextInputType.name,
              ),
              const CustomTextField(
                padding: EdgeInsets.only(top: 20),
                labelText: "Sobrenome",
                prefixIcon: Icons.assignment_ind_outlined,
                keyboardType: TextInputType.name,
              ),
              const CustomTextField(
                padding: EdgeInsets.only(top: 20),
                labelText: "Celular",
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.name,
              ),
              const CustomTextField(
                padding: EdgeInsets.only(top: 20),
                labelText: "Email",
                prefixIcon: Icons.email,
                keyboardType: TextInputType.name,
              ),
              const CustomTextField(
                padding: EdgeInsets.only(top: 20),
                labelText: "Senha",
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.name,
              ),
              const CustomTextField(
                padding: EdgeInsets.only(top: 20),
                labelText: "Confirma Senha",
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.name,
              ),
              RadioListTile(
                title: Text("Maxo"),
                value: "T",
                groupValue: "grup",
                onChanged: (value) {},
              ),
              RadioListTile(
                title: Text("Famia"),
                value: "T",
                groupValue: "grup",
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
