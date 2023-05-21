import 'package:flutter/material.dart';

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
