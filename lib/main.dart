import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cola_completa.dart';
import 'cola_simple.dart';
import 'calendario.dart';

import 'datos.dart';
import 'cola.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final cola = Get.put(Cola());
  final turno = Get.put(Turno.desdeHoraDuracion('Ale', 1, 4, 8 * 60 + 30));

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cola de espera',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: PageView(children: const [
        Calendario(),
        ColaSimple(),
        ColaCompleta(),
      ])),
    );
  }
}
