import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:get/get.dart';

import 'utils.dart';

enum Estados { configurando, ejecutando, mostrando }

class Cola extends GetxController {
  Estados estado = Estados.configurando;

  late DateTime inicio;
  late DateTime actual;
  late DateTime ultimo;

  int cantidad = 0;
  List<int> marcas = [];

  Cola() {
    inicio = DateTime.now();
    actual = inicio;
    ultimo = inicio;
    estado = Estados.configurando;
  }

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    iniciarTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void iniciarTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) => actualizarEstado());
  }

  void comenzar() {
    estado = Estados.configurando;
    cantidad = 1;
    marcas.clear();
    tocar();
  }

  void ejecutar() {
    if (cantidad < cantidadMinima) return;

    estado = Estados.ejecutando;
    inicio = DateTime.now();
    tocar();
  }

  void mostrar() {
    estado = Estados.mostrando;
    tocar();
  }

  void avanzar() {
    if (configurando) {
      if (cantidad < cantidadMaxima) cantidad++;
    }

    if (ejecutando) marcas.add(inicio.segundos);

    tocar();
  }

  void retroceder() {
    if (configurando) {
      if (cantidad > 0) cantidad--;
    }

    if (ejecutando) {
      if (marcas.isNotEmpty) marcas.removeLast();
    }

    tocar();
  }

  void tocar() {
    ultimo = DateTime.now();
    update();
  }

  void actualizarEstado() {
    if (configurando) {
      if (ultimo.segundos >= esperaEjecucion && cantidad >= cantidadMinima) ejecutar();
    }

    if (ejecutando) {
      actual = DateTime.now();
      if (personasFaltantes == 0) mostrar();
    }

    if (mostrando) {
      if (ultimo.segundos >= esperaReiniciar) comenzar();
    }

    update();
  }

  // Estados
  bool get configurando => estado == Estados.configurando;
  bool get ejecutando => estado == Estados.ejecutando;
  bool get mostrando => estado == Estados.mostrando;

  // Estadísticas
  int get atendidos => min(cantidad, personasAtendidas);
  int get esperando => max(0, personasFaltantes);

  DateTime get horaComienzo => inicio;
  DateTime get horaActual => actual;
  DateTime get horaUltimo => marcas.isEmpty ? inicio : inicio.add(Duration(seconds: marcas.last));
  DateTime get horaFinalizacion => inicio.add(Duration(seconds: esperaTotal));

  int get esperaPromedio {
    int estimada = esperaActual ~/ (atendidos + 1);
    int espera = atendidos == 0 ? duracionMinima : marcas.last ~/ atendidos;
    return max(espera, estimada);
  }

  int get esperaActual => actual.difference(inicio).inSeconds;
  int get esperaTotal =>
      max((marcas.isEmpty ? 0 : marcas.last) + esperaPromedio, esperaActual) + esperaPromedio * (esperando - 1);
  int get esperaAtencion => esperaTotal - esperaActual;
  int get esperaExcedida => actual.segundos;
  int get esperaSalida => (cantidad + 1) * esperaPromedio;

  int get personasComienzo => cantidad;
  int get personasAtendidas => marcas.length;
  int get personasFaltantes => personasComienzo - personasAtendidas;
  int get personas => configurando ? personasComienzo : personasFaltantes;
  int get espera => ejecutando ? esperaAtencion : esperaTotal;

// Parámetros

  static const duracionMinima = 5;
  static const duracionEstimada = 30;

  static const cantidadMinima = 2;
  static const cantidadMaxima = 20;

  static const esperaEjecucion = 3; // 10
  static const esperaReiniciar = 12; // esperaPromedio x 2

  static Cola get to => Get.find();
}
