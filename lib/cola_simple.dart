import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utils.dart';
import 'boton.dart';
import 'linea.dart';
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
        children: [Cantidad(cola), crearTiempo(cola), Linea(cola), crearCompartir(cola)],
      )));

  Widget crearCompartir(Cola cola) {
    if (!cola.mostrando) return Container();
    return Boton('Compartir' , () => enviarWhatapp(cola));
  }

  Widget crearTiempo(Cola cola) {
    if (cola.configurando) return Container();

    final color = cola.ejecutando ? Colors.white : Colors.yellow;
    final estilo = TextStyle(fontSize: 80, color: color, fontWeight: FontWeight.w200);
    return Text(cola.espera.toIntervalo(), style: estilo);
  }

  void enviarWhatapp(Cola cola) {
    final texto = '''https://wa.me/3815343458?text=*Cola de espera*

El día ${DateTime.now().toDia} a las ${cola.horaComienzo.toHora}
Habia ${cola.cantidad} personas

Esperé ${cola.esperaTotal.toIntervalo()} (promedio ${cola.esperaPromedio.toIntervalo()})

${cola.marcas.map((x) => '-${x.toIntervalo()}').join("\n")}''';

    final url = Uri.parse(texto);
    launchUrl(url);
  }
}
