import 'package:intl/intl.dart';

bool compareGameDate(DateTime gameDate, DateTime filterDate) {
  return gameDate.year == filterDate.year && gameDate.month == filterDate.month && gameDate.day == filterDate.day;
}

String friendlyHourAndTimeZone(DateTime dateTime) {
  DateTime localDateTime = dateTime.toLocal();
  return DateFormat.jm().format(localDateTime) + ' ' + localDateTime.timeZoneName;
}
