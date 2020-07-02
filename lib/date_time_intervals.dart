library date_time_intervals;

import 'package:enum_to_string/enum_to_string.dart';

export 'intervals.dart';

enum CalendarDirection { between, sinceEnd, untilEnd }

enum CalendarItem {
  years,
  months,
  days,
  hours,
  minutes,
  seconds,
}

String calendarItemsAsString(Set<CalendarItem> items) {
  String result = '';
  for (CalendarItem item in items) {
    if (result.length > 0) result += ',';
    result += EnumToString.parse(item);
  }
  return result;
}

Set<CalendarItem> calendarItemsFrom({String string}) {
  Set<CalendarItem> result = Set();
  CalendarItem.values.forEach((element) {
    final key = EnumToString.parse(element).toLowerCase();
    if (string.toLowerCase().contains(key)) result.add(element);
  });
  return result;
}
