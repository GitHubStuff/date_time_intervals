// Copyright 2020 LTMM. All rights reserved.
// Uses of this source code is governed by 'The Unlicense' that can be
// found in the LICENSE file.

import 'package:date_time_intervals/date_time_intervals.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Timer Interval Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Push the button:',
            ),
            Text(
              '',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DateTimeIntervals dti = ahead26Hours3minutes();
          debugPrint('months: ${dti.months} days: ${dti.days} hours: ${dti.hours} minutes: ${dti.minutes}');
          final str = calendarItemsAsString({CalendarItem.years, CalendarItem.seconds});
          debugPrint('str: $str');
          String date = dti.launchDate() + " " + dti.launchTime();
          debugPrint('date: $date');

          dti = ahead1year26Hours3minutes();
          date = dti.launchDate(includeDirection: true) + " " + dti.launchTime();
          debugPrint('date: $date');

          dti = ahead16hr14min11se();
          date = dti.launchDate() + " " + dti.launchTime();
          debugPrint('date: $date');

          dti = ahead16hr14min11se();
          date = dti.launchTime();
          debugPrint('date: $date');

          dti = behind23Hours3minutes10second();
          date = dti.launchTime(includeDirection: true);
          debugPrint('date: $date');

          dti = ahead22Hours5minutes15second();
          date = dti.launchTime(includeDirection: true);
          debugPrint('date: $date');
        },
        tooltip: 'Push',
        child: Icon(Icons.add),
      ),
    );
  }
}

DateTimeIntervals behind23Hours3minutes10second() {
  final eventDateTime = DateTime.now().toUtc().subtract(Duration(
        hours: 23,
        minutes: 3,
        seconds: 10,
      ));
  return DateTimeIntervals.fromCurrentDateTime(
    eventDateTime: eventDateTime,
    setOfCalendarItems: {
      CalendarItem.years,
      CalendarItem.days,
      CalendarItem.hours,
      CalendarItem.minutes,
      CalendarItem.seconds,
    },
  );
}

DateTimeIntervals ahead22Hours5minutes15second() {
  final eventDateTime = DateTime.now().toUtc().add(Duration(
        hours: 22,
        minutes: 5,
        seconds: 15,
      ));
  return DateTimeIntervals.fromCurrentDateTime(
    eventDateTime: eventDateTime,
    setOfCalendarItems: {
      CalendarItem.years,
      CalendarItem.days,
      CalendarItem.hours,
      CalendarItem.minutes,
      CalendarItem.seconds,
    },
  );
}

DateTimeIntervals ahead26Hours3minutes() {
  final eventDateTime = DateTime.now().toUtc().add(Duration(hours: 26, minutes: 3));
  return DateTimeIntervals(
    endEvent: eventDateTime,
    startEvent: DateTime.now().toUtc(),
    setOfCalendarItems: {
      CalendarItem.years,
      CalendarItem.days,
      CalendarItem.hours,
      CalendarItem.minutes,
      CalendarItem.seconds,
    },
  );
}

DateTimeIntervals ahead1year26Hours3minutes() {
  final eventDateTime = DateTime.now().toUtc().add(Duration(days: 399, hours: 26, minutes: 3, seconds: 4));
  return DateTimeIntervals(
    endEvent: eventDateTime,
    startEvent: DateTime.now().toUtc(),
    setOfCalendarItems: {
      CalendarItem.years,
      CalendarItem.months,
      CalendarItem.days,
      CalendarItem.hours,
      CalendarItem.minutes,
      CalendarItem.seconds,
    },
  );
}

DateTimeIntervals ahead16hr14min11se() {
  final eventDateTime = DateTime.now().toUtc().add(Duration(hours: 16, minutes: 14, seconds: 11));
  return DateTimeIntervals(
    endEvent: eventDateTime,
    startEvent: DateTime.now().toUtc(),
    setOfCalendarItems: {
      CalendarItem.hours,
      CalendarItem.minutes,
      CalendarItem.seconds,
    },
  );
}
