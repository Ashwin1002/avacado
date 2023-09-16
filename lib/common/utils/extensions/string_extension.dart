import 'package:intl/intl.dart';

_engDateFormatToHalfMonthDay({required String date}) {
  DateTime convDate = DateTime.parse(date);
  DateFormat formatedDate = DateFormat('MMM dd, y');
  String finalDate = formatedDate.format(convDate);
  return finalDate;
}

extension StringExtension on String {
  String capitalize() => trim().isEmpty
      ? ''
      : trim().substring(0, 1).toUpperCase() + trim().substring(1);

  String toAMPM() =>
      "${trim()} ${(int.parse(trim().substring(0, 2)) > 11 ? "PM" : "AM")}";

  String toHourMinSec() => DateFormat('hh:mm a').format(DateTime.parse(trim()));

  String convertToHex() => int.parse(trim().replaceAll("#", "0XFF")).toString();

  String toTimeDurationFromNow() {
    try {
      if (trim().isNotEmpty) {
        final input = DateTime.parse(trim());
        Duration diff = DateTime.now().difference(input);
        if (diff.inDays >= 1) {
          return '${diff.inDays} days ago';
        } else if (diff.inHours >= 1) {
          return '${diff.inHours} hours ago';
        } else if (diff.inMinutes >= 1) {
          return '${diff.inMinutes} minutes ago';
        } else if (diff.inSeconds >= 1) {
          return '${diff.inSeconds} seconds ago';
        } else {
          return 'just now';
        }
      }
      return 'week ago';
    } catch (e) {
      throw Exception('Error while parsing ${trim()}');
    }
  }

  String toEnglishDate() =>
      _engDateFormatToHalfMonthDay(date: trim().substring(0, 10));

  String insertHash() => trim().isEmpty ? '' : trim().replaceAll(" ", " #");
}
