
import 'cola_completa.dart';
import 'cola_simple.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Cola de espera',
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: ColaCompleta()),
    );
  }
}



