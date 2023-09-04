import 'package:flutter/material.dart';

import 'boton.dart';
import 'cola.dart';

class Accion extends StatelessWidget {
  final Cola cola;
  const Accion(this.cola, {super.key});

  @override
  Widget build(BuildContext context) => switch (cola.estado) {
        Estados.configurando => Boton('Comenzar', cola.ejecutar),
        Estados.ejecutando => Boton('Cancelar', cola.comenzar),
        Estados.mostrando => Boton('Reiniciar', cola.comenzar)
      };
}
