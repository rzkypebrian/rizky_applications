import 'package:intl/intl.dart';

import 'SystemUtil.dart';

extension DynamicEctention on DateTime {
  String toLocalFormat(
      {String dateFormat, String dateLocalFormat, String altIfNull}) {
    if (this == null) return altIfNull ?? "-";
    return DateFormat(dateFormat ?? System.data.resource.dateFormat,
            dateLocalFormat ?? System.data.resource.dateLocalFormat)
        .format(
      this,
    );
  }

  int get daysInMounth {
    switch (this.month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        return 31;
        break;
      case 2:
        return this.year % 4 == 0 ? 29 : 28;
        break;
      default:
        return 30;
        break;
    }
  }
}
