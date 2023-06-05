import 'package:app_tcc/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewCampaign extends StatefulWidget {
  const NewCampaign({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<NewCampaign> createState() => _NewCampaign();
}

class _NewCampaign extends State<NewCampaign> {
  late final UserModel userModel;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          ListTile(
            title: Text("aqui"),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).pushNamed('/cadCamp', arguments: userModel);
        },
        child: const Icon(Icons.add_circle_outline_outlined, size: 50),
      ),
    );
  }
}
