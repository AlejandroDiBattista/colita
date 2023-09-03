import 'utils.dart';
import 'cola.dart';

import 'reloj.dart';
import 'accion.dart';
import 'contador.dart';
import 'estado_cola.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColaCompleta extends StatelessWidget {
  const ColaCompleta({super.key});

  @override
  Widget build(BuildContext context) {
    final Cola cola = Get.find();
    return GetBuilder<Cola>(
        init: cola,
        builder: (cola) => Center(
            child: Container(
                decoration: crearFondo(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Reloj(), EstadoCola(cola), Contador(cola), Accion(cola)],
                ))));
  }
}
