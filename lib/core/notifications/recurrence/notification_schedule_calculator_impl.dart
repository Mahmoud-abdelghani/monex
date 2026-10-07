import 'dart:math';

import 'package:monex/core/notifications/enums/notification_recurrence.dart';
import 'package:monex/core/notifications/notification_request.dart';
import 'package:monex/core/notifications/recurrence/notification_schedule_calculator.dart';

class NotificationScheduleCalculatorImpl
    implements NotificationScheduleCalculator {
  @override
  DateTime? calculateNextScheduleAfter(
    NotificationRequest request,
    DateTime date,
  ) {
    switch (request.recurrence) {
      case NotificationRecurrence.none:
        return null;
      case NotificationRecurrence.daily:
        return date.add(const Duration(days: 1));
      case NotificationRecurrence.weekly:
        return date.add(const Duration(days: 7));
      case NotificationRecurrence.monthly:
        return _calculateNextScheduleAfterWhenMonthly(request, date);
      case NotificationRecurrence.yearly:
        return _calculateNextScheduleAfterWhenYearly(request, date);
    }
  }

  @override
  List<DateTime> calculateSchedules(NotificationRequest request) {
    switch (request.recurrence) {
      case NotificationRecurrence.none:
        return [request.endDate!];
      case NotificationRecurrence.daily:
        return _calculateDailySchedules(request);
      case NotificationRecurrence.weekly:
        return _calculateWeeklySchedules(request);
      case NotificationRecurrence.monthly:
        return _calculateMonthlySchedules(request);
      case NotificationRecurrence.yearly:
        return _calculateYearlySchedules(request);
    }
  }

  List<DateTime> _calculateDailySchedules(NotificationRequest request) {
    List<DateTime> schedules = [];
    DateTime startDate = request.scheduleDate;
    while (!startDate.isAfter(request.endDate!)) {
      schedules.add(startDate);
      startDate = startDate.add(const Duration(days: 1));
    }
    return schedules;
  }

  List<DateTime> _calculateWeeklySchedules(NotificationRequest request) {
    List<DateTime> schedules = [];
    DateTime startDate = request.scheduleDate;
    while (!startDate.isAfter(request.endDate!)) {
      schedules.add(startDate);
      startDate = startDate.add(const Duration(days: 7));
    }
    return schedules;
  }

  List<DateTime> _calculateMonthlySchedules(NotificationRequest request) {
    final schedules = <DateTime>[];
    var startDate = request.scheduleDate;
    final originalDay = request.scheduleDate.day;
    while (!startDate.isAfter(request.endDate!)) {
      schedules.add(startDate);
      startDate = DateTime(
        startDate.year,
        startDate.month + 1,
        min(
          _lastDayOfTheMonth(startDate.month + 1, startDate.year),
          originalDay,
        ),
        startDate.hour,
        startDate.minute,
        startDate.second,
      );
    }
    return schedules;
  }

  List<DateTime> _calculateYearlySchedules(NotificationRequest request) {
    final schedules = <DateTime>[];
    var startDate = request.scheduleDate;
    final originalDay = request.scheduleDate.day;
    while (!startDate.isAfter(request.endDate!)) {
      schedules.add(startDate);
      startDate = DateTime(
        startDate.year + 1,
        startDate.month,
        min(
          _lastDayOfTheMonth(startDate.month, startDate.year + 1),
          originalDay,
        ),
        startDate.hour,
        startDate.minute,
        startDate.second,
      );
    }
    return schedules;
  }

  DateTime? _calculateNextScheduleAfterWhenMonthly(
    NotificationRequest request,
    DateTime date,
  ) {
    final originalDay = request.scheduleDate.day;
    final nextMonth = date.month == 12 ? 1 : date.month + 1;
    final nextYear = date.month == 12 ? date.year + 1 : date.year;
    return DateTime(
      nextYear,
      nextMonth,
      min(_lastDayOfTheMonth(nextMonth, nextYear), originalDay),
      date.hour,
      date.minute,
      date.second,
    );
  }

  DateTime? _calculateNextScheduleAfterWhenYearly(
    NotificationRequest request,
    DateTime date,
  ) {
    final originalDay = request.scheduleDate.day;
    return DateTime(
      date.year + 1,
      date.month,
      min(_lastDayOfTheMonth(date.month, date.year + 1), originalDay),
      date.hour,
      date.minute,
      date.second,
    );
  }

  int _lastDayOfTheMonth(int month, int year) {
    return DateTime(year, month + 1, 0).day;
  }
}
