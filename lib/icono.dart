import 'package:flutter/material.dart';

class Icono extends StatelessWidget {
  final IconData tipo;
  final VoidCallback accion;

  const Icono(this.tipo, this.accion, {super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: accion,
        icon: Icon(tipo),
        iconSize: 64,
        color: Colors.white60,
      );
}
