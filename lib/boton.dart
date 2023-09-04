import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  final String titulo;
  final VoidCallback accion;
  const Boton(this.titulo, this.accion, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
}
