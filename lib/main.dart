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
                children: [Reloj(), EstadoCola(c), Contador(c), Accion(c)],
              ),
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
    final ahora = DateTime.now();
    return Padding(
      padding: const EdgeInsets.only(top: 64),
      child: Center(child: Text(ahora.toHoraCompleta, style: const TextStyle(fontSize: 48, color: Colors.white))),
    );
  }
}

class Campo extends StatelessWidget {
  final String etiqueta;
  final String valor;
  final bool destacar;
  const Campo(this.etiqueta, this.valor, {this.destacar = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(etiqueta, style: const TextStyle(fontSize: 16, color: Colors.white54, fontWeight: FontWeight.w100)),
          Text(valor,
              style: TextStyle(
                  fontSize: 24,
                  color: destacar ? Colors.yellow : Colors.white,
                  fontWeight: destacar ? FontWeight.bold : FontWeight.normal)),
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
    if (cola.estado == Estados.configurando) return Container();
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

class Contador extends StatelessWidget {
  final Cola cola;
  const Contador(this.cola, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cola.avanzar,
      onLongPress: cola.retroceder,
      child: Center(
        child: Column(
          children: [
            if (cola.estado != Estados.mostrando) ...[
              const Text('¿Cuantas personas hay antes?',
                  style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w100)),
              Text('${cola.personas}', style: const TextStyle(fontSize: 180, color: Colors.white)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  icono(Icons.add_circle_outline, cola.avanzar),
                  icono(Icons.remove_circle_outline, cola.retroceder)
                ],
              ),
            ],
            //if (cola.estado == Estados.configurando) const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget icono(IconData tipo, VoidCallback accion) => IconButton(
        onPressed: accion,
        icon: Icon(tipo),
        iconSize: 96,
        color: Colors.white60,
      );
}

class Accion extends StatelessWidget {
  final Cola cola;
  const Accion(this.cola, {super.key});

  @override
  Widget build(BuildContext context) => switch (cola.estado) {
        Estados.configurando => crearBoton('Comenzar', cola.ejecutar),
        Estados.ejecutando => crearBoton('Cancelar', cola.comenzar),
        Estados.mostrando => crearBoton('Reiniciar', cola.comenzar)
      };

  Widget crearBoton(String titulo, VoidCallback accion) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.3), // Ajusta el nivel de transparencia aquí
            ),
            onPressed: accion,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(titulo, style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w300)),
            )),
      );
}

BoxDecoration crearFondo() => const BoxDecoration(
        gradient: LinearGradient(
      colors: [Color.fromARGB(255, 156, 39, 176), Color.fromARGB(255, 33, 155, 243)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ));
