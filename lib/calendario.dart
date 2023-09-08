import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'datos.dart';

class Calendario extends StatelessWidget {
  const Calendario({super.key});

  @override
  Widget build(BuildContext context) {
    final Turno turno = Get.find();
    return GetBuilder<Turno>(
        init: turno,
        builder: (turno) => Center(
                child: CustomPaint(
              painter: DibujarTurno(turno),
              size: const Size(350, 700),
            )));
  }
}

class DibujarTurno extends CustomPainter {
  final Turno turno;
  DibujarTurno(this.turno);

  @override
  void paint(Canvas canvas, Size size) {
    print(turno);
    dibujarPlantilla(canvas, size);
    dibujarTurno(canvas, size);
  }

  final cuerpo = Paint()
    ..color = Colors.red
    ..strokeWidth = 1.0
    ..style = PaintingStyle.fill;

  final lineas = Paint()
    ..color = Colors.grey
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;

  final subLineas = Paint()
    ..color = Colors.grey.shade200
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;

  final borde = Paint()
    ..color = Colors.black
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke;

  void dibujarTurno(Canvas canvas, Size size) {
    final i = ubicar(size, turno.dia - 1, turno.horaInicio);
    final f = ubicar(size, turno.dia, turno.horaFinal);

    var t = RRect.fromLTRBR(i.dx, i.dy, f.dx, f.dy, const Radius.circular(0));
    t = t.inflate(-1);
    canvas.drawRRect(t, cuerpo);
    //canvas.drawRRect(t, borde);
    dibujarTexto(canvas, size, turno.quien, Colors.white, turno.dia - 1, turno.horaInicio);
  }

  final intervalo = 30 / 60;
  void dibujarPlantilla(Canvas canvas, Size size) {
    for (int h = 0; h <= horas; h++) {
      if (h < horas) {
        for (double aux = intervalo; aux < 1; aux += intervalo) {
          canvas.drawLine(ubicar(size, 0, h + aux), ubicar(size, dias, h + aux), subLineas);
        }
      }
      canvas.drawLine(ubicar(size, -1, h), ubicar(size, dias, h), (0 == h || h == horas) ? borde : lineas);
      if (h < horas) dibujarTexto(canvas, size, '${h.toString().padLeft(2, '0')}:00', Colors.green, -1, h);
    }

    for (int d = 0; d <= dias; d++) {
      canvas.drawLine(ubicar(size, d, -1), ubicar(size, d, horas), (d == 0 || d == dias) ? borde : lineas);
      if (d < dias) dibujarTexto(canvas, size, '${d.toString().padLeft(2, '0')}/09', Colors.green, d, -1);
    }
  }

  void dibujarTexto(Canvas canvas, Size size, String texto, Color color, num dia, num hora) {
    final t = TextSpan(text: texto, style: TextStyle(fontSize: 10, color: color));
    final p = TextPainter(text: t, textDirection: TextDirection.ltr, textAlign: TextAlign.center);
    final s = ubicar(size, 1, 1) - ubicar(size, 0, 0);
    p.layout(maxWidth: s.dx);

    final centerX = (s.dx - p.width) / 2;
    final centerY = (s.dy - p.height) / 2;

    p.paint(canvas, ubicar(size, dia, hora) + Offset(centerX, centerY));
  }

  final margen = 0.1;
  final dias = 7;
  final horas = 24;

  Offset ubicar(Size size, num dia, num hora) {
    final alto = size.height / (horas * (1 + 2 * margen));
    final ancho = size.width / (dias * (1 + 2 * margen));
    return Offset(ancho * (dia + 1), alto * (hora + 1));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
