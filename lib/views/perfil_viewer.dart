import 'package:app_tcc/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                      child: const Icon(
                        Icons.photo_camera_outlined,
                        size: 120,
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          PhosphorIcons.regular.pencilSimple,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomTextField(
              enabled: false,
              padding: const EdgeInsets.only(top: 20),
              labelText: "Nome",
              prefixIcon: Icons.assignment_ind_outlined,
              keyboardType: TextInputType.name,
            ),
            CustomTextField(
              enabled: false,
              padding: const EdgeInsets.only(top: 20),
              labelText: "Sobrenome",
              prefixIcon: Icons.assignment_ind_outlined,
              keyboardType: TextInputType.name,
            ),
            CustomTextField(
              enabled: false,
              padding: const EdgeInsets.only(top: 20),
              labelText: "Celular",
              prefixIcon: Icons.phone,
              keyboardType: TextInputType.name,
            ),
            CustomTextField(
              enabled: false,
              padding: const EdgeInsets.only(top: 20),
              labelText: "Email",
              prefixIcon: Icons.email,
              keyboardType: TextInputType.name,
            ),
            CustomTextField(
              enabled: false,
              padding: const EdgeInsets.only(top: 20),
              labelText: "Estado",
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.name,
              obscureText: true,
            ),
            CustomTextField(
              enabled: false,
              padding: const EdgeInsets.only(top: 20),
              labelText: "Cidade",
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.name,
              obscureText: true,
            ),
            CustomTextField(
              enabled: false,
              padding: const EdgeInsets.only(top: 20),
              labelText: "Cep",
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.name,
              obscureText: true,
            ),
            CustomTextField(
              enabled: false,
              padding: const EdgeInsets.only(top: 20),
              labelText: "Numero",
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.name,
              obscureText: true,
            ),
            CustomTextField(
              enabled: false,
              padding: const EdgeInsets.only(top: 20),
              labelText: "Endereço",
              prefixIcon: Icons.lock,
              keyboardType: TextInputType.name,
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }
}
