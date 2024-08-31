import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recicla_facil/features/coletor/listagem_propostas/listagem_proposta_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recicla fácil',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ListagemPropostaPage(),
    );
  }
}
