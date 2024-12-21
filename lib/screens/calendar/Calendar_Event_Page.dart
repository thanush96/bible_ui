import 'package:flutter/material.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:timezone/timezone.dart' as tz;

class CalendarEventPage extends StatefulWidget {
  @override
  _CalendarEventPageState createState() => _CalendarEventPageState();
}

class _CalendarEventPageState extends State<CalendarEventPage> {
  final DeviceCalendarPlugin _deviceCalendarPlugin = DeviceCalendarPlugin();
  List<Calendar> _calendars = [];
  String? _calendarId;

  @override
  void initState() {
    super.initState();
    _fetchCalendars();
  }

  Future<void> _fetchCalendars() async {
    var permissionsGranted = await _deviceCalendarPlugin.hasPermissions();
    if (permissionsGranted.isSuccess && !permissionsGranted.data!) {
      final result = await _deviceCalendarPlugin.requestPermissions();
      permissionsGranted = result;
    }

    if (permissionsGranted.isSuccess && permissionsGranted.data!) {
      final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
      setState(() {
        _calendars = calendarsResult.data ?? [];
        // Find the first writable calendar by checking permissions
        _calendarId = _calendars.lastWhere(
          (calendar) {
            // Check if the calendar is writeable by checking for permission
            return calendar.id != null;
          },
          orElse: () => _calendars.first, // fallback to the first calendar
        ).id;
      });

      // Debug: Print all available calendars and their writable status
      for (var calendar in _calendars) {
        print('Calendar: ${calendar.name}, ID: ${calendar.id}');
      }
    }
  }

  Future<void> _addEvent(description, start, end) async {
    if (_calendarId == null) return;

    final event = Event(
      _calendarId,
      title: 'Prayer Alert',
      description: description,
      start: start,
      end: end,
    );

    print('_calendarId $_calendarId');

    final result = await _deviceCalendarPlugin.createOrUpdateEvent(event);
    if (result?.isSuccess == true && result?.data != null) {
      print(result?.data);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Event added successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add event')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final start =
        tz.TZDateTime(tz.getLocation('Asia/Colombo'), 2024, 12, 21, 16, 0);
    final end =
        tz.TZDateTime(tz.getLocation('Asia/Colombo'), 2024, 12, 21, 17, 0);

    const description = "This is an event from amusic bible app";

    return Scaffold(
      appBar: AppBar(title: const Text('Add Calendar Event')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _addEvent(description, start, end);
          },
          child: const Text('Add Event to Calendar'),
        ),
      ),
    );
  }
}
