import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'datos.dart';

const num margen = 0.1;
const num horas = 24;
const num dias = 7;
const num intervalo = 15 / 60;

class Calendario extends StatelessWidget {
  final Size size;
  const Calendario(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    final Turno turno = Get.find();
    return GetBuilder<Turno>(
      init: turno,
      builder: (turno) => Center(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("Calendario", style: TextStyle(fontSize: 30, color: Colors.black)),
          ),
          CustomPaint(painter: DibujarTurno(turno), size: size),
        ],
      )),
    );
  }
}

class DibujarTurno extends CustomPainter {
  final Turno turno;
  DibujarTurno(this.turno);

  @override
  void paint(Canvas canvas, Size size) {
    dibujarPlantilla(canvas, size);
    dibujarTurno(canvas, size);
  }

  final cuerpo = Paint()
    ..color = Colors.blue
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
    final i = size.toPoint(turno.dia - 1, turno.horaInicio);
    final f = size.toPoint(turno.dia, turno.horaFinal);

    var t = RRect.fromLTRBR(i.dx, i.dy, f.dx, f.dy, const Radius.circular(0));
    t = t.inflate(-1);
    canvas.drawRRect(t, cuerpo);
    dibujarTexto(canvas, size, turno.quien, Colors.white, turno.dia - 1, turno.horaInicio);
  }

  void dibujarPlantilla(Canvas canvas, Size size) {
    for (int h = 0; h <= horas; h++) {
      if (h < horas) {
        for (var aux = intervalo; aux < 1; aux += intervalo) {
          canvas.drawLine(size.toPoint(0, h + aux), size.toPoint(dias, h + aux), subLineas);
        }
      }
      canvas.drawLine(size.toPoint(-1, h), size.toPoint(dias, h), (0 == h || h == horas) ? borde : lineas);
      if (h < horas) dibujarTexto(canvas, size, '${h.toString().padLeft(2, '0')}:00', Colors.green, -1, h);
    }

    for (int d = 0; d <= dias; d++) {
      canvas.drawLine(size.toPoint(d, -1), size.toPoint(d, horas), (d == 0 || d == dias) ? borde : lineas);
      if (d < dias) dibujarTexto(canvas, size, '${d.toString().padLeft(2, '0')}/09', Colors.green, d, -1);
    }
  }

  void dibujarTexto(Canvas canvas, Size size, String texto, Color color, num dia, num hora) {
    final t = TextSpan(text: texto, style: TextStyle(fontSize: 10, color: color));

    final p = TextPainter(text: t, textDirection: TextDirection.ltr, textAlign: TextAlign.center);
    final s = size.toPoint(1, 1) - size.toPoint(0, 0);
    p.layout(maxWidth: s.dx);

    final centerX = (s.dx - p.width) / 2;
    final centerY = (s.dy - p.height) / 2;

    p.paint(canvas, size.toPoint(dia, hora) + Offset(centerX, centerY));
  }

  // Offset ubicarXY(Size size, num dia, num hora) {
  //   final alto = size.height / (horas * (1 + 2 * margen));
  //   final ancho = size.width / (dias * (1 + 2 * margen));
  //   return Offset(ancho * (dia + 1), alto * (hora + 1));
  // }

  // Offset ubicarDH(Size size, num x, num y) {
  //   final alto = size.height / (horas * (1 + 2 * margen));
  //   final ancho = size.width / (dias * (1 + 2 * margen));
  //   return Offset((x - ancho) / ancho, (y - alto) / alto);
  // }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

extension SizeExtensions on Size {
  Offset toPoint(num dia, num hora) {
    final alto = height / (horas * (1 + 2 * margen));
    final ancho = width / (dias * (1 + 2 * margen));
    return Offset(ancho * (dia + 1), alto * (hora + 1));
  }

  Offset fromPoint(num x, num y) {
    final alto = height / (horas * (1 + 2 * margen));
    final ancho = width / (dias * (1 + 2 * margen));
    return Offset((x - ancho) / ancho, (y - alto) / alto);
  }
}
