import 'package:intl/intl.dart';
import 'package:weather_app/mobile/constants/key.dart';
import 'package:weather_app/mobile/storage/custom_shared_preferences.dart';

class DateTimeHelper {
  static String languageCode = LocalStorageService.getString(
    KeyStorage.LANGUAGE_CODE,
  );

  static String getWeekday(DateTime day) {
    // Map weekdayList = {
    //   1: 'T2',
    //   2: 'T3',
    //   3: 'T4',
    //   4: 'T5',
    //   5: 'T6',
    //   6: 'T7',
    //   7: 'CN',
    // };
    String locale = LocalStorageService.getString(KeyStorage.LANGUAGE_CODE);
    locale = locale != '' ? locale : 'vi';
    // if (locale == 'vi') {
    //   return weekdayList[day.weekday];
    // } else {
    return DateFormat.EEEE().format(day);
    // }
  }

  static bool isSameDay(DateTime date, DateTime otherDate) {
    return date.year == otherDate.year &&
        date.month == otherDate.month &&
        date.day == otherDate.day;
  }
}
