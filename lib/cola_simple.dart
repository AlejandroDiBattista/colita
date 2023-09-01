import 'utils.dart';
import 'cola.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColaSimple extends StatelessWidget {
  const ColaSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Cola>(
      init: Cola(),
      builder: (cola) => Center(
        child: Container(
          decoration: crearFondo(),
          child: MiniCola(cola: cola),
        ),
      ),
    );
  }
}

class MiniCola extends StatelessWidget {
  final Cola cola;
  const MiniCola({required this.cola, super.key});

  @override
  Widget build(BuildContext context) {
    const esperando = TextStyle(fontSize: 64, color: Colors.white, fontWeight: FontWeight.w200);
    const mostrando = TextStyle(fontSize: 64, color: Colors.yellow, fontWeight: FontWeight.w400);
    return InkWell(
      onTap: cola.mostrando ? cola.comenzar : cola.avanzar,
      onLongPress: cola.mostrando ? cola.comenzar : cola.retroceder,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!cola.mostrando)
              Text('${cola.personas}',
                  style: TextStyle(
                    fontSize: 180,
                    color: cola.configurando ? Colors.blue.shade200 : Colors.white,
                    shadows: [crearSombra()],
                  )),
            if (cola.ejecutando) Text(cola.esperaAtencion.toIntervalo(), style: esperando),
            if (cola.mostrando) Text(cola.esperaTotal.toIntervalo(), style: mostrando)
          ],
        ),
      ),
    );
  }
}
