import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:date_time_intervals/date_time_intervals.dart';

void main() {
  test('date intervals', () {
    final startEvent = DateTime(2020, 4, 11, 17, 33, 00);
    final endEvent = DateTime(2020, 12, 12, 20, 00, 00);

    final calculator = DateTimeIntervals(setOfCalendarItems: {
      CalendarItem.months,
      CalendarItem.days,
      CalendarItem.hours,
      CalendarItem.minutes,
      CalendarItem.seconds,
    }, startEvent: startEvent, endEvent: endEvent);
    expect(calculator.months, 8);
    debugPrint('months: ${calculator.months}');
    expect(calculator.days, 1);
    expect(calculator.hours, 2);
    expect(calculator.minutes, 27);
    expect(calculator.seconds, 00);
  });
}
