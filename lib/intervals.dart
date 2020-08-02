import 'package:flutter/material.dart';

import 'date_time_intervals.dart';

const int _HOURS_PER_DAY = 24;
const int _MONTHS_PER_YEAR = 12;
const int _MINUTES_PER_HOUR = 60;
const int _MINUTES_PER_DAY = 1440;
const int _SECONDS_PER_DAY = 86400;
const int _SECONDS_PER_HOUR = 3600;
const int _SECONDS_PER_MINUTE = 60;

class DateTimeIntervals {
  // NOTE: null means wasn't requested
  int get years => _years;
  int get months => _months;
  int get days => _days;
  int get hours => _hours;
  int get minutes => _minutes;
  int get seconds => _seconds;
  CalendarDirection get direction => _direction;

  int _years;
  int _months;
  int _days;
  int _hours;
  int _minutes;
  int _seconds;
  CalendarDirection _direction;

  DateTimeIntervals({
    @required Set<CalendarItem> setOfCalendarItems,
    @required DateTime startEvent,
    @required DateTime endEvent,
  }) {
    DateTime startingDateTime = _timeWrapper(startEvent);
    DateTime endingDateTime = _timeWrapper(endEvent);
    if (startEvent == null || endEvent == null || setOfCalendarItems.isEmpty) return;
    _direction =
        startingDateTime.compareTo(endingDateTime) > 0 ? CalendarDirection.sinceEnd : CalendarDirection.untilEnd;
    if (_direction == CalendarDirection.sinceEnd) {
      startingDateTime = _timeWrapper(endEvent);
      endingDateTime = _timeWrapper(startEvent);
    }
    _direction = CalendarDirection.between;

    if (setOfCalendarItems.contains(CalendarItem.years) || setOfCalendarItems.contains(CalendarItem.months)) {
      _approximateInterval(setOfCalendarItems, startingDateTime, endingDateTime);
    } else {
      _exactInterval(setOfCalendarItems, startingDateTime, endingDateTime);
    }
  }
  factory DateTimeIntervals.fromCurrentDateTime({
    @required Set<CalendarItem> setOfCalendarItems,
    @required DateTime eventDateTime,
  }) {
    final endDateTime = DateTime.now();
    DateTimeIntervals dateTimeIntervals = DateTimeIntervals(
      setOfCalendarItems: setOfCalendarItems,
      startEvent: eventDateTime,
      endEvent: endDateTime,
    );
    final duration = endDateTime.difference(eventDateTime);
    dateTimeIntervals._direction = (duration.isNegative) ? CalendarDirection.untilEnd : CalendarDirection.sinceEnd;
    return dateTimeIntervals;
  }

  String formattedString(
      {List<String> yearPlurality = const ['year', 'years'],
      List<String> monthsPlurality = const ['month', 'months'],
      List<String> daysPlurality = const ['day', 'days'],
      List<String> hoursPlurality = const ['hour', 'hours'],
      List<String> minutesPlurality = const ['minute', 'minutes'],
      List<String> secondsPlurality = const ['second', 'seconds']}) {
    if (yearPlurality.length != 2) throw FlutterError('"years" must have two values');
    if (monthsPlurality.length != 2) throw FlutterError('"months" must have two values');
    if (daysPlurality.length != 2) throw FlutterError('"days" must have two values');
    if (hoursPlurality.length != 2) throw FlutterError('"hours" must have two values');
    if (minutesPlurality.length != 2) throw FlutterError('"minutes" must have two values');
    if (secondsPlurality.length != 2) throw FlutterError('"seconds" must have two values');
    String _result = '';
    void add(int value, List<String> unit) {
      if (value == null) return;
      if (_result.isNotEmpty) _result = '$_result ';
      final theUnit = (value == 1) ? unit[0] : unit[1];
      _result = '$_result$value $theUnit';
    }

    add(_years, yearPlurality);
    add(_months, monthsPlurality);
    add(_days, daysPlurality);
    add(_hours, hoursPlurality);
    add(_minutes, minutesPlurality);
    add(_seconds, secondsPlurality);
    return _result;
  }

  //Rebuild DateTime micro and milli seconds set to zero(0)
  DateTime _timeWrapper(DateTime dateTime) {
    return (dateTime == null)
        ? null
        : DateTime(
            dateTime.year,
            dateTime.month,
            dateTime.day,
            dateTime.hour,
            dateTime.minute,
            dateTime.second,
            0,
            0,
          );
  }

  void _approximateInterval(Set<CalendarItem> setOfCalendarItems, DateTime startingDateTime, DateTime endingDateTime) {
    int getTotalMonths(DateTime startEvent, DateTime endEvent) {
      int months = 0;
      while (DateTime(
            startEvent.year,
            (startEvent.month + months + 1),
            startEvent.day,
            startEvent.hour,
            startEvent.minute,
            startEvent.second,
          ).compareTo(endEvent) <
          0) {
        months++;
      }
      return months;
    }

    int totalMonths = getTotalMonths(startingDateTime, endingDateTime);
    _years = !setOfCalendarItems.contains(CalendarItem.years) ? null : totalMonths ~/ _MONTHS_PER_YEAR;
    _months =
        !setOfCalendarItems.contains(CalendarItem.months) ? null : totalMonths - ((_years ?? 0) * _MONTHS_PER_YEAR);
    DateTime adjustedEvent = DateTime(
      startingDateTime.year,
      startingDateTime.month + totalMonths,
      startingDateTime.day,
      startingDateTime.hour,
      startingDateTime.minute,
      startingDateTime.second,
    );
    final duration = endingDateTime.difference(adjustedEvent);
    _days = !setOfCalendarItems.contains(CalendarItem.days) ? null : duration.inDays;
    _hours =
        !setOfCalendarItems.contains(CalendarItem.hours) ? null : duration.inHours - ((_days ?? 0) * _HOURS_PER_DAY);
    _minutes = !setOfCalendarItems.contains(CalendarItem.minutes)
        ? null
        : duration.inMinutes - ((_hours ?? 0) * _MINUTES_PER_HOUR) - ((_days ?? 0) * _MINUTES_PER_DAY);
    _seconds = !setOfCalendarItems.contains(CalendarItem.seconds)
        ? null
        : duration.inSeconds -
            ((_days ?? 0) * _SECONDS_PER_DAY) -
            ((_hours ?? 0) * _SECONDS_PER_HOUR) -
            ((_minutes ?? 0) * _SECONDS_PER_MINUTE);
  }

  void _exactInterval(Set<CalendarItem> setOfCalendarItems, DateTime startingDateTime, DateTime endingDateTime) {
    _days = !setOfCalendarItems.contains(CalendarItem.days) ? null : endingDateTime.difference(startingDateTime).inDays;
    _hours = !setOfCalendarItems.contains(CalendarItem.hours)
        ? null
        : endingDateTime.difference(startingDateTime).inHours - ((_days ?? 0) * _HOURS_PER_DAY);
    _minutes = !setOfCalendarItems.contains(CalendarItem.minutes)
        ? null
        : endingDateTime.difference(startingDateTime).inMinutes -
            ((_hours ?? 0) * _MINUTES_PER_HOUR) -
            ((_days ?? 0) * _MINUTES_PER_DAY);
    _seconds = !setOfCalendarItems.contains(CalendarItem.seconds)
        ? null
        : endingDateTime.difference(startingDateTime).inSeconds -
            ((_days ?? 0) * _SECONDS_PER_DAY) -
            ((_hours ?? 0) * _SECONDS_PER_HOUR) -
            ((_minutes ?? 0) * _SECONDS_PER_MINUTE);
  }
}
