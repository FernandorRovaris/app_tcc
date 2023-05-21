import 'dart:developer';

import 'package:app_tcc/Utils/utils.dart';
import 'package:app_tcc/controllers/user_controller.dart';
import 'package:app_tcc/custom_exeption/api_exeption.dart';
import 'package:app_tcc/models/user_model.dart';
import 'package:app_tcc/repositories/user_repository.dart';
import 'package:app_tcc/service/dio_api_service.dart';
import 'package:app_tcc/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginViewer extends StatefulWidget {
  const LoginViewer({super.key});

  @override
  State<LoginViewer> createState() => _LoginViewerState();
}

class _LoginViewerState extends State<LoginViewer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool modeInsert = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(217, 217, 217, 1000),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.only(top: 150),
            child: Column(
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
                    child: const Icon(
                      Icons.group_add_sharp,
                      size: 120,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                const Text(
                  "Doar-se",
                  style: TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                CustomTextField(
                  controller: emailController,
                  padding: const EdgeInsets.all(20),
                  labelText: "Email",
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe seu Email";
                    } else {
                      return null;
                    }
                  },
                ),
                CustomTextField(
                  controller: senhaController,
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  labelText: "Senha",
                  prefixIcon: Icons.lock_person_outlined,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Informe sua senha";
                    } else {
                      return null;
                    }
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(left: 45, top: 3),
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => log("clik"),
                    child: const Text(
                      "Esqueci a Senha",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(20),
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
                    onPressed: modeInsert ? null : auth,
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
                            "Entrar",
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Ainda não possue conta?",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed("/caduser"),
                        child: const Text(
                          "Cadastre-se",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> auth() async {
    if (_formKey.currentState!.validate()) {
      UserModel? userModel = UserModel();

      UserController controller =
          UserController(UserRepository(DioApiService()));

      try {
        setState(() {
          modeInsert = true;
        });

        userModel = await controller.authUser(
            emailController.text.trim(), senhaController.text.trim());

        if (mounted) {
          messageAlert("Sucesso user ${userModel!.nome}", context);
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
