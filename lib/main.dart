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
  final turno = Get.put(Turno.desdeHoraDuracion('Marcelo', 1, 4, 8 * 60 + 30));
  final size = Size(Get.width, Get.height - 200);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cola de espera',
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            body: PageView(children: [
          GestureDetector(
            child: Calendario(size),
            onPanStart: (d) {
              final f = d.globalPosition;
              print('star: $d > ${size.fromPoint(f.dx, f.dy)}');
            },
            onPanUpdate: (d) {
              final f = d.globalPosition;
              print('update: $d > ${size.fromPoint(f.dx, f.dy)}');
              turno.ubicar(size.fromPoint(f.dx, f.dy));
            },
            onPanEnd: (d) {
              print('end: $d.');
            },
          ),
          const ColaSimple(),
          const ColaCompleta(),
        ])),
      ),
    );
  }
}
