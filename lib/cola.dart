import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    leer();
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
    guardar();
  }

  void ejecutar() {
    if (cantidad < cantidadMinima) return;

    estado = Estados.ejecutando;
    inicio = DateTime.now();
    tocar();
    guardar();
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
    guardar();
  }

  void retroceder() {
    if (configurando) {
      if (cantidad > 0) cantidad--;
    }

    if (ejecutando) {
      if (marcas.isNotEmpty) marcas.removeLast();
    }

    tocar();
    guardar();
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
  static const cantidadMaxima = 50;

  static const esperaEjecucion = 3; // 10
  static const esperaReiniciar = 12; // esperaPromedio x 2

  static Cola get to => Get.find();

  void guardar() async {
    print("Comenzando guardar... $cantidad");
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('estado', estado.index);
    prefs.setInt('cantidad', cantidad);
    prefs.setStringList('marcas', marcas.map((e) => e.toString()).toList());
    prefs.setString('inicio', inicio.toIso8601String());
    prefs.setString('actual', actual.toIso8601String());
    prefs.setString('ultimo', ultimo.toIso8601String());
    print("guardando... $cantidad");
  }

  void leer() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('estado') == null) return;

    estado = Estados.values[prefs.getInt('estado') ?? 0];
    cantidad = prefs.getInt('cantidad') ?? 0;
    marcas = prefs.getStringList('marcas')?.map((e) => int.parse(e)).toList() ?? [];
    inicio = DateTime.parse(prefs.getString('inicio') ?? '1970-01-01T00:00:00Z');
    actual = DateTime.parse(prefs.getString('actual') ?? '1970-01-01T00:00:00Z');
    ultimo = DateTime.parse(prefs.getString('ultimo') ?? '1970-01-01T00:00:00Z');
    print("Leyendo $cantidad");
  }
}
