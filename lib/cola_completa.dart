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
    return GetBuilder<Cola>(
      init: Cola(),
      builder: (cola) => Center(
        child: Container(
          decoration: crearFondo(),
          child: MaxiCola(cola: cola),
        ),
      ),
    );
  }
}

class MaxiCola extends StatelessWidget {
  final Cola cola;
  const MaxiCola({required this.cola, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Reloj(), EstadoCola(cola), Contador(cola), Accion(cola)],
    );
  }
}
