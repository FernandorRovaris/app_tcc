import 'package:app_tcc/controllers/user_controller.dart';
import 'package:app_tcc/repositories/user_repository.dart';
import 'package:app_tcc/service/dio_api_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserController userController = UserController(
    UserRepository(
      DioApiService(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
