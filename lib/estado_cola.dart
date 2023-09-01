import 'utils.dart';
import 'cola.dart';

import 'campo.dart';

import 'package:flutter/material.dart';

class EstadoCola extends StatelessWidget {
  final Cola cola;
  const EstadoCola(this.cola, {super.key});

  @override
  Widget build(BuildContext context) {
    final c = cola;
    if (cola.configurando) return Container();
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(50),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: Colors.white.withAlpha(10)),
      ),
      child: Column(children: [
        fila(
          hora('Hora comienzo', c.horaComienzo),
          intervalo('Espera promedio', c.esperaPromedio),
        ),
        fila(
          hora('Hora último', c.horaUltimo),
          intervalo('Espera total', c.esperaActual),
        ),
        fila(
          hora('Hora finalización', c.horaFinalizacion, destacar: true),
          cola.esperando == 0
              ? intervalo('Tiempo excedido', c.esperaExcedida, destacar: true)
              : intervalo('Tiempo atención', c.esperaAtencion, destacar: true),
        ),
        fila(entero('Comenzaron con', c.personasComienzo), entero('Atendieron a', c.personasAtendidas)),
      ]),
    );
  }

  Widget fila(Widget a, Widget b) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [a, b]),
      );

  Widget hora(String etiqueta, DateTime hora, {bool destacar = false}) =>
      Campo(etiqueta, hora.toHora, destacar: destacar);
  Widget intervalo(String etiqueta, int segundos, {bool destacar = false}) =>
      Campo(etiqueta, segundos.toIntervalo(), destacar: destacar);
  Widget entero(String etiqueta, int cantidad, {bool destacar = false}) =>
      Campo(etiqueta, cantidad.toString(), destacar: destacar);
}
