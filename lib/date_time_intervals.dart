library date_time_intervals;

export 'source/intervals.dart';

enum CalendarDirection { sinceEnd, untilEnd }

enum CalendarItem {
  years,
  months,
  days,
  hours,
  minutes,
  seconds,
}
