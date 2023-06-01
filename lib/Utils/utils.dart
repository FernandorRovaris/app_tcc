import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

Future<dynamic> messageAlert(String msg, BuildContext context) {
  return showDialog(
    context: context,
    builder: ((context) {
      return AlertDialog(
        title: const Text("Alerta"),
        content: Text(msg),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"))
        ],
      );
    }),
  );
}

void showOpcoesBottomSheet(BuildContext context, void Function() getGaleria,
    void Function() getCamera, void Function() removeImage) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: Center(
                  child: Icon(
                    PhosphorIcons.regular.image,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              title: Text(
                'Galeria',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: getGaleria,
            ),
            ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      PhosphorIcons.regular.camera,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Câmera',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: getCamera),
            ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: Center(
                    child: Icon(
                      PhosphorIcons.regular.trash,
                      color: Colors.grey[500],
                    ),
                  ),
                ),
                title: Text(
                  'Remover',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                onTap: removeImage),
          ],
        ),
      );
    },
  );
}
