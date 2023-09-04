import 'package:colita/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// import 'cola.dart';

class Circular extends StatelessWidget {
  final DateTime tiempo;
  const Circular(this.tiempo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 100.0,
      height: 100.0,
      child: CustomPaint(painter: Circulo(110)),
    ));
  }
}

class Circulo extends CustomPainter {
  final double valor;
  final double radio;
  final double ancho;
  final Color color;

  Circulo(this.valor, {this.radio = 100.0, this.ancho = 4, this.color = Colors.red});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = ancho
      ..strokeCap = StrokeCap.round;
    final fondo = Paint()..color = Colors.green;

    final inicio = getRadians(-90);
    final angulo = getRadians(valor);
    final centro = Rect.fromCircle(center: size.center(Offset.zero), radius: radio);

    canvas.drawCircle(size.center(Offset.zero), radio, fondo);
    canvas.drawArc(centro, inicio, angulo, true, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  double getRadians(double angle) {
    return angle * pi / 180;
  }
}
