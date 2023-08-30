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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (estado == Estados.configurando) {
        update();
      } else {
        actualizar();
      }
    });
  }

  void actualizar() {
    switch (estado) {
      case Estados.configurando:
        if (ultimo.segundos > esperaEjecucion) comenzar();
        break;
      case Estados.ejecutando:
        actual = DateTime.now();
        if (personasFaltantes == 0) mostrar();
        break;
      case Estados.mostrando:
        if (ultimo.segundos > esperaReiniciar) reiniciar();
        break;
    }
    update();
  }

  void comenzar() {
    estado = Estados.ejecutando;
    inicio = DateTime.now();
    tocar();
  }

  void mostrar() {
    estado = Estados.mostrando;
    tocar();
  }

  void reiniciar() {
    estado = Estados.configurando;
    cantidad = 0;
    marcas.clear();
    tocar();
  }

  void avanzar() {
    if (estado == Estados.configurando) {
      if (cantidad < cantidadMaxima) cantidad++;
    } else if (esperando > 0) {
      marcas.add(inicio.segundos);
    }
    tocar();
    actualizar();
  }

  void retroceder() {
    if (estado == Estados.configurando) {
      if (cantidad > 0) cantidad--;
    } else {
      marcas.removeLast();
    }
    tocar();
    actualizar();
  }

  void tocar() {
    ultimo = DateTime.now();
    update();
  }

  // Estadísticas

  int get atendidos => min(cantidad, personasAtendidas);
  int get esperando => max(0, personasFaltantes);

  DateTime get horaComienzo => inicio;
  DateTime get horaActual => actual;
  DateTime get horaFinalizacion => inicio.add(Duration(seconds: esperaTotal));

  int get esperaPromedio {
    int ajuste = esperaActual ~/ (atendidos + 1);
    int duracionTotal = atendidos == 0 ? 0 : marcas.last;
    int duracion = atendidos == 0 ? duracionMinima : duracionTotal ~/ atendidos;
    return max(duracion, ajuste);
  }

  int get esperaActual => inicio.difference(actual).inSeconds;
  int get esperaTotal => esperaPromedio * cantidad;
  int get esperaParaAtencion => esperaTotal - esperaActual;

  int get personasComienzo => cantidad;
  int get personasAtendidas => marcas.length;
  int get personasFaltantes => personasComienzo - personasAtendidas;

// Parámetros
  static const duracionMinima = 5;
  static const duracionEstimada = 30;
  static const cantidadMaxima = 20;
  static const esperaEjecucion = 10;
  static const esperaReiniciar = 30;

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

  static Cola get to => Get.find();
}
