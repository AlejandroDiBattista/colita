import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:get/get.dart';

import 'utils.dart';

class Cola extends GetxController {
  bool configurar = true;

  late DateTime inicio;
  late DateTime actual;

  int cantidad = 0;
  List<int> marcas = [];

  Cola() {
    inicio = DateTime.now();
    actual = inicio;
  }

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (configurando) {
        update();
      } else {
        actualizar();
      }
    });
  }

  void actualizar() {
    update();
    if (configurando || completado) return;

    actual = DateTime.now();
  }

  void comenzar() {
    inicio = DateTime.now();
    configurar = false;
    actualizar();
  }

  void cancelar() {
    configurar = true;
    actualizar();
  }

  void terminar() {
    configurar = true;
    actualizar();
  }

  void avanzar() {
    if (configurar) {
      if (cantidad < cantidadMaxima) cantidad++;
    } else if (esperando > 0) {
      marcas.add(inicio.segundos);
    }
    actualizar();
  }

  void retroceder() {
    if (configurar) {
      if (cantidad > 0) cantidad--;
    } else {
      marcas.removeLast();
    }
    actualizar();
  }

  int get atendidos => min(cantidad, personasAtendidas);
  int get esperando => max(0, personasFaltantes);
  int get duracionTotal => atendidos == 0 ? 0 : marcas.last;

  int get duracionPromedio {
    int ajuste = esperaTotal ~/ (atendidos + 1);
    int duracion = atendidos == 0 ? duracionMinima : duracionTotal ~/ atendidos;
    return max(duracion, ajuste);
  }

  // Parámetros
  static const duracionMinima = 5;
  static const duracionEstimada = 30;
  static const cantidadMaxima = 20;

  // Estadísticas

  DateTime get horaComienzo => inicio;
  DateTime get horaActual => actual;
  DateTime get horaFinalizacion => inicio.add(Duration(seconds: tiempoTotal));

  int get esperaPromedio => duracionPromedio;
  int get esperaTotal => inicio.difference(actual).inSeconds;

  int get tiempoParaAtencion => tiempoTotal - esperaTotal;
  int get tiempoTotal => duracionPromedio * cantidad;

  int get personasComienzo => cantidad;
  int get personasAtendidas => marcas.length;
  int get personasFaltantes => personasComienzo - personasAtendidas;

  bool get configurando => configurar;
  bool get ejecutando => !configurando && personasFaltantes > 0;
  bool get completado => !configurando && personasFaltantes == 0;

  static Cola crearDemo() {
    final c = Cola();
    c.cantidad = 5;
    c.inicio = c.inicio.subtract(const Duration(seconds: 50));
    c.avanzar();
    c.marcas.last = c.marcas.last - 40;
    c.avanzar();
    c.marcas.last = c.marcas.last - 20;
    return c;
  }

  static Cola get to => Get.find(); // add this line
}
