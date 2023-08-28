import 'utils.dart';
import 'cola.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GetBuilder<Cola>(
          init: Cola(),
          builder: (c) => Center(
            child: Container(
              decoration: crearFondo(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Reloj(c), if (!c.configurando) EstadoCola(c), Contador(c)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Reloj extends StatelessWidget {
  final Cola cola;
  const Reloj(this.cola, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64),
      child: Center(child: Text(cola.horaActual.toHora, style: const TextStyle(fontSize: 48, color: Colors.white))),
    );
  }
}

class Campo extends StatelessWidget {
  final String etiqueta;
  final String valor;

  const Campo(this.etiqueta, this.valor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(etiqueta, style: const TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w100)),
          Text(valor, style: const TextStyle(fontSize: 20, color: Colors.white)),
        ],
      ),
    );
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

  Widget fila(Widget a, Widget b) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [a, b]),
      );

  Widget hora(String etiqueta, DateTime hora) => Campo(etiqueta, hora.toHora);
  Widget intervalo(String etiqueta, int segundos) => Campo(etiqueta, segundos.toIntervalo());
  Widget entero(String etiqueta, int cantidad) => Campo(etiqueta, cantidad.toString());
}

class Contador extends StatelessWidget {
  final Cola cola;
  const Contador(this.cola, {super.key});

  void sumar() {
    cola.avanzar();
  }

  void restar() {
    cola.retroceder();
  }

  void comenzar() {
    cola.comenzar();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cola.avanzar,
      onLongPress: cola.retroceder,
      child: Column(
        children: [
          const Text('¿Cuantas personas hay antes?',
              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w100)),
          Text('${cola.configurando ? cola.cantidad : cola.esperando}',
              style: const TextStyle(fontSize: 200, color: Colors.white)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [icono(Icons.add_circle_outline, sumar), icono(Icons.remove_circle_outline, restar)],
          ),
          cola.configurando ? crearComenzar() : const SizedBox(height: 24)
        ],
      ),
    );
  }

  Widget icono(IconData tipo, VoidCallback accion) => IconButton(
        onPressed: accion,
        icon: Icon(tipo),
        iconSize: 64,
        color: Colors.white,
      );

  Widget crearComenzar() => Padding(
        padding: const EdgeInsets.all(24.0),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.3), // Ajusta el nivel de transparencia aquí
              padding: EdgeInsets.all(16),
            ),
            onPressed: cola.comenzar,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Comenzar", style: TextStyle(fontSize: 32, color: Colors.white)),
            )),
      );
}

BoxDecoration crearFondo() => const BoxDecoration(
        gradient: LinearGradient(
      colors: [Color.fromARGB(255, 156, 39, 176), Color.fromARGB(255, 33, 155, 243)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ));
