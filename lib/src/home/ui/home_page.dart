import 'package:desafio_target/src/auth/ui/login_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Olá, mundo")),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Voltar"),
        icon: BackButtonIcon(),
        onPressed: () => Navigator.popAndPushNamed(context, LoginPage.routeName),
      ),
    );
  }
}
