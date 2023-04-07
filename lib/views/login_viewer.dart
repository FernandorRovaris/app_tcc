import 'dart:developer';

import 'package:app_tcc/widgets/custom_textField.dart';
import 'package:flutter/material.dart';

class LoginViewer extends StatelessWidget {
  const LoginViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(217, 217, 217, 1000),
      body: SingleChildScrollView(
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
              const CustomTextField(
                padding: EdgeInsets.all(20),
                labelText: "Email",
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const CustomTextField(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                labelText: "Senha",
                prefixIcon: Icons.lock_person_outlined,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
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
                    backgroundColor: const Color.fromARGB(202, 199, 199, 1000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    side: const BorderSide(
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/caduser");
                  },
                  child: const Text(
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
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                      onPressed: () {},
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
    );
  }
}
