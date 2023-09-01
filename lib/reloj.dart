import 'utils.dart';
import 'package:flutter/material.dart';

class Reloj extends StatelessWidget {
  const Reloj({super.key});

  @override
  Widget build(BuildContext context) {
    final ahora = DateTime.now();
    return Padding(
      padding: const EdgeInsets.only(top: 64),
      child: Center(
          child: Text(ahora.toHora,
              style: const TextStyle(fontSize: 64, color: Colors.white, fontWeight: FontWeight.w100))),
    );
  }
}
