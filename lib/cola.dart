import 'dart:core';
import 'dart:math';

extension DateTimeExtensions on DateTime {
  int get segundos => DateTime.now().difference(this).inSeconds;
}

class Cola {
  int cantidad;
  late DateTime inicio;
  List<int> marcas = [];

  Cola(this.cantidad) {
    inicio = DateTime.now();
  }

  void avanzar() {
    if (esperando == 0) return;
    marcas.add(inicio.segundos);
  }

  void retroceder() {
    marcas.removeLast();
  }

  int get atendidos => min(cantidad, marcas.length);
  int get esperando => max(0, cantidad - atendidos);
  int get duracionTotal => atendidos == 0 ? 0 : marcas.last;

  int get duracionPromedio {
    final ahora = inicio.segundos;
    int ajuste = ahora ~/ (atendidos + 1);
    int duracion = atendidos == 0 ? duracionMinima : duracionTotal ~/ atendidos;
    return max(duracion, ajuste);
  }

  static const duracionMinima = 5;
  static const duracionEstimada = 30;

  // Estadisticas

  DateTime get horaActual => DateTime.now();

  DateTime get horaComienzo => inicio;
  DateTime get horaFinalizacion => inicio.add(Duration(seconds: tiempoTotal));

  int get esperaPromedio => duracionPromedio;
  int get esperaTotal => inicio.segundos;

  int get tiempoAtencion => tiempoTotal - esperaTotal;
  int get tiempoTotal => duracionPromedio * cantidad;

  int get personasComienzo => cantidad;
  int get personasAtendidas => marcas.length;

  int get personasFaltantes => personasComienzo - personasAtendidas;

  static Cola crearDemo() {
    final c = Cola(5);
    c.inicio = c.inicio.subtract(const Duration(seconds: 50));
    c.avanzar();
    c.marcas.last = c.marcas.last - 40;
    c.avanzar();
    c.marcas.last = c.marcas.last - 20;
    return c;
  }
}
