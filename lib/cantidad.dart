import 'package:flutter/material.dart';

import 'utils.dart';
import 'cola.dart';

class Cantidad extends StatelessWidget {
  final Cola cola;
  const Cantidad(this.cola, {super.key});

  @override
  Widget build(BuildContext context) {
    if (cola.mostrando) return Container();
    return Text('${cola.personas}',
        style: TextStyle(
          fontSize: 180,
          color: cola.configurando ? Colors.blue.shade200 : Colors.white,
          shadows: [crearSombra()],
        ));
  }
}
