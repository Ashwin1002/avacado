final now = DateTime.now();

class TimeUtils {
  final hourAgo =
      DateTime(now.year, now.month, now.day, now.hour - 1).toString();

  final fifteenMinutesAgo =
      DateTime(now.year, now.month, now.day, now.hour, now.minute - 15)
          .toString();

  final fiveHoursAgo =
      DateTime(now.year, now.month, now.day, now.hour - 5).toString();

  final aDayAgo = DateTime(now.year, now.month, now.day - 1).toString();

  final justNow = now.toString();
}
