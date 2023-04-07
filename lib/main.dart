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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Doar-se",
      theme: ThemeData(
        primaryColor: const Color.fromARGB(217, 217, 217, 1000),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginViewer(),
        '/caduser': (context) => const CadUserViewer(),
      },
    );
  }
}
