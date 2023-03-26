import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../lsd_page_controller.dart';

class ErrorScreenWidget extends StatelessWidget {
  const ErrorScreenWidget({
    Key? key,
    required this.error,
  }) : super(key: key);

  final dynamic error;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            const Text(
              "Ocorreu um erro",
              textAlign: TextAlign.center,
            ),
            const Text(
              "Não foi possível carregar as informações.",
              textAlign: TextAlign.center,
            ),
            const Text(
              "Verifique sua conexão e tente novamente",
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              child: const Text("Tentar novamente"),
              onPressed: () => context.read<LsdPageController>().refresh(),
            ),
          ],
        ),
      ),
    );
  }
}
