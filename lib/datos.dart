import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Turno extends GetxController {
  String quien;
  DateTime desde;
  int duracion;

  Turno(this.quien, this.desde, [this.duracion = 60]);

  static Turno get to => Get.find();

  double get horaInicio => desde.hour.toDouble();
  double get horaFinal => horaInicio + duracion / 60;
  double get dia => desde.day.toDouble();
  @override
  String toString() => 'Turno($quien, $horaInicio a $horaFinal)';

  void ubicar(Offset posicion) {
    desde = desde.copyWith(day: posicion.dx.toInt(), hour: posicion.dy.toInt());
    print("ubicar: $posicion");
    update();
  }

  factory Turno.desdeHoraDuracion(String quien, int dia, int hora, int duracion) => Turno(
        quien,
        DateTime(2023, 9, dia, hora),
        duracion,
      );
}
