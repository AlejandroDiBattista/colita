import 'package:flutter/material.dart';

extension DateTimeExtensions on DateTime {
  int get segundos => DateTime.now().difference(this).inSeconds;
  String get toHora => '${hour.twoDigits()}:${minute.twoDigits()}:${second.twoDigits()}';
  String get toHoraCompleta => '${hour.twoDigits()}:${minute.twoDigits()}:${second.twoDigits()}.${microsecond ~/ 100}';
}

extension IntExtensions on int {
  String twoDigits() => toString().padLeft(2, '0');
  String toIntervalo() {
    int minutos = this ~/ 60;
    int segundos = this % 60;
    return '${minutos.twoDigits()}:${segundos.twoDigits()}';
  }
}

BoxDecoration crearFondo() => const BoxDecoration(
        gradient: LinearGradient(
      colors: [Color.fromARGB(255, 156, 39, 176), Color.fromARGB(255, 33, 155, 243)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ));

Shadow crearSombra() => const Shadow(color: Colors.black45, offset: Offset(0, 0), blurRadius: 20.0);
