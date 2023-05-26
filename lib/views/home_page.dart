import 'dart:io';

import 'package:app_tcc/controllers/user_controller.dart';
import 'package:app_tcc/repositories/user_repository.dart';
import 'package:app_tcc/service/dio_api_service.dart';
import 'package:app_tcc/views/new_camp_viewer.dart';
import 'package:app_tcc/views/perfil_viewer.dart';
import 'package:app_tcc/views/time_line_viewer.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  UserController userController = UserController(
    UserRepository(
      DioApiService(),
    ),
  );

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ))
        ],
      ),
      body: TabBarView(
        physics: const ScrollPhysics(
          parent: NeverScrollableScrollPhysics(),
        ),
        controller: _tabController,
        children: [
          const TimeLineHome(),
          const NewCampaign(),
          Container(
            color: Colors.black,
          ),
          const Perfil()
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        controller: _tabController,
        backgroundColor: Theme.of(context).primaryColor,
        activeColor: Colors.black,
        items: const [
          TabItem(icon: Icons.home),
          TabItem(icon: Icons.add),
          TabItem(icon: Icons.search),
          TabItem(icon: Icons.person),
        ],
      ),
    );
  }
}
