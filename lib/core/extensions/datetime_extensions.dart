import 'package:intl/intl.dart';

extension DatetimeExtensions on DateTime {
  String formattedDate() {
    return DateFormat('${_weekDays[weekday - 1]}, dd.MM.yyyy - HH.mm')
        .format(this);
  }

  static const List<String> _weekDays = [
    'Пн',
    'Вт',
    'Ср',
    'Чт',
    'Пт',
    'Сб',
    'Вс',
  ];
}
