import 'package:app_tcc/views/cad_user_viewer.dart';
import 'package:app_tcc/views/login_viewer.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Doar-se",
      themeMode: ThemeMode.system,
      home: LoginViewer(),
    );
  }
}
