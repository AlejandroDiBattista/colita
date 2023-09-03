import 'package:colita/linea.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils.dart';
import 'cantidad.dart';
import 'cola.dart';

class ColaSimple extends StatelessWidget {
  const ColaSimple({super.key});

  @override
  Widget build(BuildContext context) {
    final Cola cola = Get.find();
    return GetBuilder<Cola>(
      init: cola,
      builder: (cola) => Center(
        child: Container(
          decoration: crearFondo(),
          child: mostrarEstado(cola),
        ),
      ),
    );
  }

  Widget mostrarEstado(Cola cola) => InkWell(
      onTap: cola.mostrando ? cola.comenzar : cola.avanzar,
      onLongPress: cola.mostrando ? cola.comenzar : cola.retroceder,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Cantidad(cola), crearTiempo(cola), Linea(cola)],
      )));

  Widget crearTiempo(Cola cola) {
    if (cola.configurando) return Container();

    final color = cola.ejecutando ? Colors.white : Colors.yellow;
    final estilo = TextStyle(fontSize: 80, color: color, fontWeight: FontWeight.w200);
    return Text(cola.espera.toIntervalo(), style: estilo);
  }
}
