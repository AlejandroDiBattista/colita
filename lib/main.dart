import 'dart:math';

import 'package:flutter/material.dart';

import 'cola.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            decoration: crearFondo(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const Reloj(), EstadoCola(Cola.crearDemo()), Contador(5, configurar: true)],
            ),
          ),
        ),
      ),
    );
  }
}

class Reloj extends StatelessWidget {
  const Reloj({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(child: Text(DateTime.now().toHora, style: const TextStyle(fontSize: 48))),
    );
  }
}

class Campo extends StatelessWidget {
  final String etiqueta;
  final String valor;

  const Campo(this.etiqueta, this.valor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(etiqueta, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w100)),
        Text(valor, style: const TextStyle(fontSize: 24, color: Colors.white)),
      ],
    );
  }
}

extension DateTimeExtensions on DateTime {
  String get toHora {
    return '${hour.twoDigits()}:${minute.twoDigits()}:${second.twoDigits()}';
  }
}

extension IntExtensions on int {
  String twoDigits() => toString().padLeft(2, '0');
  String toIntervalo() {
    int minutos = this ~/ 60;
    int segundos = this % 60;
    return '${minutos.twoDigits()}:${segundos.twoDigits()}';
  }
}

class EstadoCola extends StatelessWidget {
  final Cola cola;
  const EstadoCola(this.cola, {super.key});

  @override
  Widget build(BuildContext context) {
    final c = cola;
    return Column(children: [
      fila(
        hora('Hora comienzo', c.horaComienzo),
        hora('Hora finalización', c.horaFinalizacion),
      ),
      fila(
        intervalo('Espera promedio', c.esperaPromedio),
        intervalo('Espera total', c.esperaTotal),
      ),
      fila(
        intervalo('Tiempo atención', c.tiempoAtencion),
        intervalo('Tiempo total', c.tiempoTotal),
      ),
      fila(entero('Personas al comienzo', c.personasComienzo), entero('Personas atendidas', c.personasAtendidas)),
    ]);
  }

  Widget fila(Widget a, Widget b) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [a, b]),
    );
  }

  Widget hora(String etiqueta, DateTime hora) => Campo(etiqueta, hora.toHora);
  Widget intervalo(String etiqueta, int segundos) => Campo(etiqueta, segundos.toIntervalo());
  Widget entero(String etiqueta, int cantidad) => Campo(etiqueta, cantidad.toString());
}

class Contador extends StatefulWidget {
  bool configurar;
  int maximo;
  int valor;
  Contador(this.valor, {this.maximo = 20, this.configurar = false, super.key});

  @override
  State<Contador> createState() => _ContadorState();
}

class _ContadorState extends State<Contador> {
  int get valor => widget.valor;

  void sumar() {
    setState(() => widget.valor = min(widget.valor+1, widget.maximo));
  }

  void restar() {
    setState(() => widget.valor = max(widget.valor - 1, 0));
  }

  void comenzar() {
    setState(() => widget.configurar = false);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: sumar,
      onLongPress: restar,
      child: Column(
        children: [
          const Text('¿Cuantas personas hay antes?',
              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w100)),
          Text('$valor', style: const TextStyle(fontSize: 200, color: Colors.white)),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: sumar,
                  icon: const Icon(Icons.add_circle_outline),
                  iconSize: 64,
                ),
                IconButton(
                  onPressed: restar,
                  icon: const Icon(Icons.remove_circle_outline),
                  iconSize: 64,
                )
              ],
            ),
          ),
          widget.configurar ? crearComenzar() : const SizedBox(height: 24)
        ],
      ),
    );
  }

  Widget crearComenzar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: OutlinedButton(
          onPressed: comenzar,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Comenzar",
              style: TextStyle(fontSize: 32),
            ),
          )),
    );
  }
}

BoxDecoration crearFondo() => const BoxDecoration(
        gradient: LinearGradient(
      colors: [Colors.purple, Colors.blue],
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
    ));
