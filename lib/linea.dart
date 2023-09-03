import 'package:flutter/material.dart';
import 'cola.dart';

class Linea extends StatelessWidget {
  final Cola cola;
  const Linea(this.cola, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: double.infinity,
      height: 20.0,
      child: CustomPaint(painter: LineAndDotsPainter(cola)),
    ));
  }
}

class LineAndDotsPainter extends CustomPainter {
  final Cola cola;
  LineAndDotsPainter(this.cola);

  @override
  void paint(Canvas canvas, Size size) {
    tiempoActual(canvas, size);
    barraFondo(canvas, size);
    marcaEstimaciones(canvas, size);
    marcarTiempo(canvas, size);
    marcaMedicion(canvas, size);
  }

  void barraFondo(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(pos(size, 0, 0), pos(size, cola.esperaSalida, 0), paint);
  }

  void marcaMedicion(Canvas canvas, Size size) {
    final real = Paint()
      ..color = Colors.yellow.withAlpha(250)
      ..isAntiAlias = true
      ..strokeWidth = 3
      ..style = PaintingStyle.fill;

    for (int i = 0; i < cola.marcas.length; i++) {
      const alto = 10;
      final int x = cola.marcas[i];
      canvas.drawLine(pos(size, x, -alto ~/ 2), pos(size, x, alto ~/ 2), real);
    }
  }

  void marcarTiempo(Canvas canvas, Size size) {
    if (cola.configurando) return;

    final segundos = Paint()
      ..color = Colors.white.withAlpha(150)
      ..isAntiAlias = true
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    const menor = 10, mayor = 60;
    for (int i = 0; i < cola.esperaSalida; i += menor) {
      canvas.drawCircle(pos(size, i, 0), i % mayor == 0 ? 2 : 1, segundos);
    }
  }

  void marcaEstimaciones(Canvas canvas, Size size) {
    if (cola.mostrando) return;

    final cantidad = cola.cantidad;

    final estimacion = Paint()
      ..color = Colors.white.withAlpha(250)
      ..isAntiAlias = true
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < cantidad; i++) {
      canvas.drawCircle(pos(size, (i + 1) * cola.esperaPromedio, 0), 3.0, estimacion);
    }
  }

  void tiempoActual(Canvas canvas, Size size) {
    if (cola.configurando) return;

    final actual = Paint()
      ..color = Colors.black.withAlpha(200)
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pos(size, cola.esperaActual, 0), 5.0, actual);
  }

  Offset pos(Size size, int x, int y) {
    final escala = (size.width * 0.90) / (cola.esperaTotal + cola.esperaPromedio);
    final margen = size.width * 0.05;
    final nx = x * escala + margen;
    final ny = size.height / 2 + y;
    return Offset(nx, ny);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
