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
