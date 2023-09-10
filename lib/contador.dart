import 'package:flutter/material.dart';

import 'utils.dart';
import 'cantidad.dart';
import 'icono.dart';
import 'cola.dart';

class Contador extends StatelessWidget {
  final Cola cola;
  const Contador(this.cola, {super.key});

  @override
  Widget build(BuildContext context) {
    var estilo = TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w100, shadows: [crearSombra()]);
    return InkWell(
      onTap: cola.avanzar,
      onLongPress: cola.retroceder,
      child: Center(
        child: Column(
          children: [
            if (!cola.mostrando) ...[
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text('¿Cuantas personas hay antes?', style: estilo),
              ),
              Cantidad(cola),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icono(Icons.add_circle_outline, cola.avanzar),
                  Icono(Icons.remove_circle_outline, cola.retroceder)
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
