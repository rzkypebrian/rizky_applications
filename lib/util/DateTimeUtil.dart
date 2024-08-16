import 'package:intl/intl.dart';

import 'SystemUtil.dart';

class DateTimeUtil {
  static DateTime converDate(String json) {
    if (json == null || json == "") {
      return null;
    } else {
      if (json.contains(".")) {
        json = json.split(".").first;
      }
      return DateTime.parse(json);
    }
  }

  static DateTime parse(String data) {
    DateTime date = new DateTime.now();
    List<String> strDateTime = data.split("T");
    List<String> strDate = strDateTime[0].split("-");
    List<String> strTime = strDateTime[1].split(":");

    date = new DateTime(
        int.parse(strDate[0]),
        int.parse(strDate[1]),
        int.parse(strDate[2]),
        int.parse(strTime[0]),
        int.parse(strTime[1]),
        int.parse(strTime[2]),
        0);

    return date;
  }

  ///
  ///parse date from format dd-MM-yyyy HH:mm
  ///
  static DateTime parseFromddMMyyyyHHmm(String data) {
    DateTime date = new DateTime.now();

    List<String> strDateTime = data.split(" ");
    List<String> strDate = strDateTime[0].split("-");
    List<String> strTime = strDateTime[1].split(":");

    date = new DateTime(int.parse(strDate[2]), int.parse(strDate[1]),
        int.parse(strDate[0]), int.parse(strTime[0]), int.parse(strTime[1]), 0);

    return date;
  }

  static Duration dateDiffWithNow(DateTime date) {
    Duration difference = DateTime.now().difference(date);
    return difference;
  }

  static String getDiffDateString(DateTime toDate,
      {DateTime startDate,
      String titleHour = "hour",
      String titleMinutes = "minute",
      String titleSeconds = "second",
      String titleDay = "day",
      String titleAgo = "ago",
      String singularSuffic = "s"}) {
    Duration duration = startDate == null
        ? DateTimeUtil.dateDiffWithNow(toDate)
        : startDate.difference(toDate);

    int inHours = 0;
    int inMinutes = 0;
    int inSeconds = 0;
    int inDays = 0;

    if (duration.isNegative) {
      inHours = duration.inHours * -1;
      inMinutes = duration.inMinutes * -1;
      inSeconds = duration.inSeconds * -1;
      inDays = duration.inDays * -1;
    } else {
      inHours = duration.inHours;
      inMinutes = duration.inMinutes;
      inSeconds = duration.inSeconds;
      inDays = duration.inDays;
    }

    if (duration.inHours >= 24) {
      return "$inDays $titleDay${(inDays > 1 ? singularSuffic : "")} $titleAgo";
    } else if (inMinutes >= 60) {
      return "$inHours $titleHour${(inHours > 1 ? singularSuffic : "")} $titleAgo";
    } else if (inSeconds >= 60) {
      return "$inMinutes $titleMinutes${(inMinutes > 1 ? singularSuffic : "")} $titleAgo";
    } else {
      return "$inSeconds $titleSeconds${(inSeconds > 1 ? singularSuffic : "")} $titleAgo";
    }
  }

  static String getStringDateDiff(DateTime date) {
    return DateTimeUtil.getDiffDateString(date,
        titleDay: System.data.resource.day,
        titleMinutes: System.data.resource.minutes,
        titleSeconds: System.data.resource.seconds,
        titleHour: System.data.resource.hours,
        titleAgo: System.data.resource.ago,
        singularSuffic: System.data.resource.lang == "en" ? "s" : "");
  }

  static Map<String, int> getMapStringDate(String locale) {
    return {
      "${DateFormat("MMMM", locale).format(DateTime(1))}": 1,
      "${DateFormat("MMMM", locale).format(DateTime(2))}": 2,
      "${DateFormat("MMMM", locale).format(DateTime(3))}": 3,
      "${DateFormat("MMMM", locale).format(DateTime(4))}": 4,
      "${DateFormat("MMMM", locale).format(DateTime(5))}": 5,
      "${DateFormat("MMMM", locale).format(DateTime(6))}": 6,
      "${DateFormat("MMMM", locale).format(DateTime(7))}": 7,
      "${DateFormat("MMMM", locale).format(DateTime(8))}": 8,
      "${DateFormat("MMMM", locale).format(DateTime(9))}": 9,
      "${DateFormat("MMMM", locale).format(DateTime(10))}": 10,
      "${DateFormat("MMMM", locale).format(DateTime(11))}": 11,
      "${DateFormat("MMMM", locale).format(DateTime(12))}": 12,
    };
  }
}
