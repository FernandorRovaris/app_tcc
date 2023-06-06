import 'package:app_tcc/controllers/campanha_controller.dart';
import 'package:app_tcc/models/campanhas_model.dart';
import 'package:app_tcc/models/user_model.dart';
import 'package:app_tcc/repositories/campanha_repository.dart';
import 'package:app_tcc/service/dio_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

  Future<List<CampanhaModel>?> getCampanhasUser() async {
    CampanhaController controller =
        CampanhaController(CampanhaRepository(DioApiService()));

    return await controller.getAll(userModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getCampanhasUser(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(
                child: Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.grey),
                    strokeWidth: 5,
                  ),
                ),
              );

            default:
              if (snapshot.hasError) {
                return Container(
                  color: Colors.red,
                  child: const Center(
                    child: Text("Erro inesperado não me reprove"),
                  ),
                );
              } else {
                return _tela(context, snapshot);
              }
          }
        },
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

  Widget _tela(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              extentRatio: 0.3,
              children: [
                SlidableAction(
                  autoClose: true,
                  onPressed: (context) {},
                  backgroundColor: Colors.blue,
                  icon: Icons.check,
                  label: "Editar",
                ),
                SlidableAction(
                  autoClose: true,
                  onPressed: (context) {},
                  backgroundColor: Colors.green,
                  icon: Icons.check,
                  label: "Ativo",
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).primaryColor,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Campanha",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    snapshot.data![index].titulo,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
