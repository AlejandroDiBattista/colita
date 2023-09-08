import 'package:colita/boton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'utils.dart';
import 'pesas.dart';

class RegistrarPesas extends StatelessWidget {
  const RegistrarPesas({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Pesas>(
        init: Pesas(),
        builder: (pesas) => Center(
                child: Center(
              child: Container(
                  decoration: crearFondo(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 40),
                      const Text("Pesas", style: TextStyle(fontSize: 30, color: Colors.white)),
                      const Spacer(),
                      crearAparato("Press hombro", 30, 35),
                      crearAparato("Press hombro", 30, 35),
                      crearAparato("Press hombro", 30, 35),
                      crearAparato("Press hombro", 30, 35),
                      crearAparato("Press pecho", 40, 45),
                      Center(child: Boton("Guardar", () {}))
                    ],
                  )),
            )));
  }

  Widget crearAparato(String aparato, int a, int b) {
    const estiloAparato = TextStyle(fontSize: 25, color: Colors.yellow);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        color: Colors.red,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(aparato, style: estiloAparato),
        ),
      ),
      registro('Franco ', 10),
      registro('Alejandro', 20),
      const SizedBox(height: 5)
    ]);
  }

  Widget registro(String nombre, int peso) {
    int series = 3;
    int repeticiones = 10;

    const estiloNombre = TextStyle(fontSize: 22, color: Colors.white);
    const estiloCantidad = TextStyle(fontSize: 16, color: Colors.yellow);
    const estiloSeparador = TextStyle(fontSize: 14, color: Colors.red);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Text(
              nombre,
              style: estiloNombre,
            ),
          ),
          TextButton(
            child: Text("$series s", style: estiloCantidad),
            onPressed: () {},
          ),
          const Text("*", style: estiloSeparador),
          TextButton(
            child: Text("$repeticiones s", style: estiloCantidad),
            onPressed: () {},
          ),
          const Text("*", style: estiloSeparador),
          TextButton(
            child: Text("$peso kg", style: estiloCantidad),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
