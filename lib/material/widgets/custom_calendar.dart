import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wardeleven/base/base_styles.dart';
import 'package:wardeleven/models/patient_model.dart';

class CustomCalendar extends StatefulWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final Map<DateTime, List<PatientModel>> events;
  final Function(DateTime) selectedDayCallback;
  final Function(DateTime) focusedDayCallback;

  CustomCalendar(this.selectedDay, this.focusedDay, this.events,
      this.selectedDayCallback, this.focusedDayCallback);

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Theme.of(context).backgroundColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              color: Styles.white, borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(1990, 01, 01),
                lastDay: DateTime.utc(2040, 12, 31),
                focusedDay: widget.focusedDay,
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(widget.selectedDay, date);
                },
                eventLoader: _getEventsFromDay,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    widget.selectedDayCallback(selectedDay);
                    // _focusedDay = focusedDay;
                  });
                },
                onPageChanged: (focusedDay) {
                  widget.focusedDayCallback(focusedDay);
                },
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    markerDecoration: BoxDecoration(
                        color: Styles.black.withOpacity(0.2),
                        shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(
                      color: Styles.accentColor.withOpacity(0.7),
                      shape: BoxShape.circle,
                    )),
                headerStyle: HeaderStyle(
                  formatButtonDecoration: BoxDecoration(
                    color: Styles.primaryColor,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  formatButtonTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ));
  }

  List<PatientModel> _getEventsFromDay(DateTime day) {
    return widget.events[DateTime(day.year, day.month, day.day)] ?? [];
  }

}
