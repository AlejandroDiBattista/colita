// import 'package:colita/utils.dart';
// import 'package:colita/utils.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// import 'cola.dart';

class Circular extends StatelessWidget {
  final DateTime tiempo;
  const Circular(this.tiempo, {super.key});

  @override
  Widget build(BuildContext context) {
    final intervalo = tiempo.difference(DateTime(2023, 9, 3, 11, 20, 0));
    return Center(
        child: SizedBox(
      width: 100.0,
      height: 100.0,
      child: Stack(children: [
        CustomPaint(painter: Circulo(convertirHoraEnAngulo(intervalo.inHours), ancho: 10, radio: 100, color: Colors.red)),
        CustomPaint(
            painter: Circulo(convertirMinutosEnAngulo(intervalo.inMinutes  % 60), ancho: 10, radio: 90, color: Colors.green)),
        CustomPaint(
            painter: Circulo(convertirMinutosEnAngulo(intervalo.inSeconds % 60), ancho: 10, radio: 80, color: Colors.yellow)),
      ]),
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
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final fondo = Paint()..color = Colors.green.withAlpha(150);

    final inicio = convertirAnguloEnRadianes(0 - 90);
    final angulo = convertirAnguloEnRadianes(valor);
    final centro = Rect.fromCircle(center: size.center(Offset.zero), radius: radio);

    // canvas.drawCircle(size.center(Offset.zero), radio, fondo);
    canvas.drawArc(centro, inicio, angulo, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

double convertirAnguloEnRadianes(double angle) => angle * pi / 180;

double convertirHoraEnAngulo(int hora) => hora / 12 * 360;
double convertirMinutosEnAngulo(int minutos) => minutos / 60 * 360;
