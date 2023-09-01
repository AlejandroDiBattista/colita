import 'package:flutter/material.dart';

import 'cola.dart';

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
              child:
                  Text(titulo, style: const TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w300)),
            )),
      );
}
