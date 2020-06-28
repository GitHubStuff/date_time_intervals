# dateinterval

A Flutter package for getting date intervals (units of time between two DateTime values)

## Getting Started

Creates an object that has interval information for years. months, days, hours, minutes, seconds between two dates. (Milliseconds and Microseconds are zeroed out)

### Enums and Class

<pre>

enum CalendarDirection { sinceEnd, untilEnd }
enum CalendarItem { years, months, days, hours, minutes, seconds }

CalendarItems({
    @required Set&ltCalendarItem> setOfCalendarItems,
    @required DateTime startEvent,
    @required DateTime endEvent,
  })

</pre>

### Example Usage

<pre>
  final DateTime startTime = DateTime.now().subtract(Duration(days:1));
  final DateTime endTime = DateTime.now();
  final calendarItems = CalendarItems(setOfCalendarItems:[hour, minute, second],
    startEvent: startTime,
    endEvent: endTime);

  final int years = calendarItems.years; // null
  final int days = calendarItems.days; // null
  final int hours = calendarItems.hours; // 24
  final int minutes = calendarItems.minutes; // 0
  final int seconds = calendarItems.seconds; // 0
  final CalendarDirection direction = calendarItems.direction; // CalendarDirection.untilEnd

</pre>
**NOTE:** Any CalendarItem omitted will result in the next item having the cumulative value.
Example: If the interval is 1hr and 1min but CalendarItem.hour IS NOT in the __setOfCalendarItems__, then the 'minutes' will be 61.

### Exact vs Approximate

Because years and months are inexact (years because of leap year, months because the number of days between 15-Feb and 15-Mar can vary because of leap year but still be a month, and since some months have 30 or 31 days there is also variance in what a 'month' is.) requests that include 'Year' and/or 'Month' are inexact.

Any request for intervals that don't include both year and month are more exact, because of the Year/Month variance described.
