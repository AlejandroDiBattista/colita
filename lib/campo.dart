import 'package:flutter/material.dart';

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
