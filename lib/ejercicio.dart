import 'package:flutter/material.dart';

enum Tipo { pullDown, pressHombro, pressBanco, pressPierna }

class Ejercicio {
  DateTime fecha;
  Tipo tipo;
  int peso;
  int repeticion;

  Ejercicio(this.tipo, {this.peso = 0, this.repeticion = 1}) : fecha = DateTime.now();
}

typedef Ejercicios = List<Ejercicio>;

class Sesion {
  Ejercicios ejercicios = [];

  void registrar(Ejercicio ejercicio) {
    ejercicios.add(ejercicio);
  }
}

class MostrarEjercicio extends StatelessWidget {
  final Sesion sesion;
  const MostrarEjercicio(this.sesion, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
