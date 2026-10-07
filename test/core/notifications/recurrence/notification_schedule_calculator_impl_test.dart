import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:monex/core/notifications/enums/notification_recurrence.dart';
import 'package:monex/core/notifications/notification_request.dart';
import 'package:monex/core/notifications/recurrence/notification_schedule_calculator_impl.dart';

void main() {
  late NotificationScheduleCalculatorImpl calculator;

  setUp(() {
    calculator = NotificationScheduleCalculatorImpl();
  });

  group('NotificationScheduleCalculatorImpl - Recurrence None', () {
    test(
      'should return exactly one occurrence on the schedule date when recurrence is none',
      () {
        final scheduleDate = DateTime(2026, 10, 05, 10, 30, 0);
        final endDate = DateTime(2026, 10, 20);
        final request = NotificationRequest(
          id: '1',
          title: 'test',
          body: 'test',
          scheduleDate: scheduleDate,
          endDate: endDate,
          recurrence: NotificationRecurrence.none,
        );
        final schedules = calculator.calculateSchedules(request);
        expect(schedules.length, 1);
        expect(schedules.first, endDate);
      },
    );
  });

  group('NotificationScheduleCalculatorImpl - Recurrence Daily', () {
    test('should return a list of daily schedules until the end date', () {
      final scheduleDate = DateTime(2026, 10, 05, 10, 30, 0);
      final endDate = DateTime(2026, 10, 8, 10, 30, 0);
      final request = NotificationRequest(
        id: '1',
        title: 'test',
        body: 'test',
        scheduleDate: scheduleDate,
        endDate: endDate,
        recurrence: NotificationRecurrence.daily,
      );
      final schedules = calculator.calculateSchedules(request);

      expect(schedules.length, 4);
      expect(schedules[0], scheduleDate);
      expect(schedules[1], scheduleDate.add(const Duration(days: 1)));
      expect(schedules[2], scheduleDate.add(const Duration(days: 2)));
      expect(schedules[3], scheduleDate.add(const Duration(days: 3)));
    });
  });

  group('NotificationScheduleCalculatorImpl - Recurrence Weekly', () {
    test('should return a list of weekly schedules until the end date', () {
      final scheduleDate = DateTime(2026, 10, 07, 10, 30, 0);
      final endDate = DateTime(2026, 10, 28, 10, 30, 0);
      final request = NotificationRequest(
        id: '1',
        title: 'test',
        body: 'test',
        scheduleDate: scheduleDate,
        endDate: endDate,
        recurrence: NotificationRecurrence.weekly,
      );
      final schedules = calculator.calculateSchedules(request);

      expect(schedules.length, 4);
      expect(schedules[0].day, 7);
      expect(schedules[1].day, 14);
      expect(schedules[2], DateTime(2026, 10, 21, 10, 30, 0));
      expect(schedules[3], DateTime(2026, 10, 28, 10, 30, 0));
    });
  });

  group('NotificationScheduleCalculatorImpl - Recurrence Monthly', () {
    test('should return a list of Monthly schedules until the end date', () {
      final scheduleDate = DateTime(2026, 10, 15, 10, 30, 0);
      final endDate = DateTime(2027, 1, 15, 10, 30, 0);
      final request = NotificationRequest(
        id: '1',
        title: 'test',
        body: 'test',
        scheduleDate: scheduleDate,
        endDate: endDate,
        recurrence: NotificationRecurrence.monthly,
      );
      final schedules = calculator.calculateSchedules(request);

      expect(schedules.length, 4);
      expect(schedules[0].day, 15);
      expect(schedules[1].day, 15);
      expect(schedules[2], DateTime(2026, 12, 15, 10, 30, 0));
      expect(schedules[3], DateTime(2027, 1, 15, 10, 30, 0));
    });
  });

  group('NotificationScheduleCalculatorImpl - Recurrence Monthly Critical', () {
    test('should return a list of Monthly schedules until the end date', () {
      final scheduleDate = DateTime(2026, 1, 31, 10, 30, 0);
      final endDate = DateTime(2026, 5, 31, 10, 30, 0);
      final request = NotificationRequest(
        id: '1',
        title: 'test',
        body: 'test',
        scheduleDate: scheduleDate,
        endDate: endDate,
        recurrence: NotificationRecurrence.monthly,
      );
      final schedules = calculator.calculateSchedules(request);

      expect(schedules.length, 5);
      expect(schedules[0].day, 31);
      expect(schedules[1].day, 28);
      expect(schedules[2], DateTime(2026, 3, 31, 10, 30, 0));
      expect(schedules[3], DateTime(2026, 4, 30, 10, 30, 0));
      expect(schedules[4], DateTime(2026, 5, 31, 10, 30, 0));
    });
  });

  group('NotificationScheduleCalculatorImpl - Recurrence Yearly', () {
    test('should return a list of Yearly schedules until the end date', () {
      final scheduleDate = DateTime(2026, 10, 5, 10, 30, 0);
      final endDate = DateTime(2029, 10, 5, 10, 30, 0);
      final request = NotificationRequest(
        id: '1',
        title: 'test',
        body: 'test',
        scheduleDate: scheduleDate,
        endDate: endDate,
        recurrence: NotificationRecurrence.yearly,
      );
      final schedules = calculator.calculateSchedules(request);

      expect(schedules.length, 4);
      expect(schedules[0].day, 5);
      expect(schedules[1].day, 5);
      expect(schedules[2], DateTime(2028, 10, 5, 10, 30, 0));
      expect(schedules[3], DateTime(2029, 10, 5, 10, 30, 0));
    });
  });

  group('NotificationScheduleCalculatorImpl - Recurrence Leap Yearly', () {
    test('should return a list of Yearly schedules until the end date', () {
      final scheduleDate = DateTime(2024, 2, 29, 10, 30, 0);
      final endDate = DateTime(2028, 3, 29, 10, 30, 0);
      final request = NotificationRequest(
        id: '1',
        title: 'test',
        body: 'test',
        scheduleDate: scheduleDate,
        endDate: endDate,
        recurrence: NotificationRecurrence.yearly,
      );
      final schedules = calculator.calculateSchedules(request);

      expect(schedules.length, 5);
      expect(schedules[0].day, 29);
      expect(schedules[1].day, 28);
      expect(schedules[2], DateTime(2026, 2, 28, 10, 30, 0));
      expect(schedules[3], DateTime(2027, 2, 28, 10, 30, 0));
      expect(schedules[4], DateTime(2028, 2, 29, 10, 30, 0));
    });
  });

  group('NotificationScheduleCalculatorImpl - Next Schedule Daily', () {
    test('should return the next daily occurrence', () {
      final scheduleDate = DateTime(2026, 10, 5, 10, 30);

      final request = NotificationRequest(
        id: '1',
        title: 'test',
        body: 'test',
        scheduleDate: scheduleDate,
        endDate: null,
        recurrence: NotificationRecurrence.daily,
      );

      final result = calculator.calculateNextScheduleAfter(
        request,
        scheduleDate,
      );

      expect(result, DateTime(2026, 10, 6, 10, 30));
    });
  });

  group('NotificationScheduleCalculatorImpl - Next Schedule Weekly', () {
    test('should return the next weekly occurrence', () {
      final scheduleDate = DateTime(2026, 10, 7, 10, 30);

      final request = NotificationRequest(
        id: '1',
        title: 'test',
        body: 'test',
        scheduleDate: scheduleDate,
        endDate: null,
        recurrence: NotificationRecurrence.weekly,
      );

      final result = calculator.calculateNextScheduleAfter(
        request,
        scheduleDate,
      );

      expect(result, DateTime(2026, 10, 14, 10, 30));
    });
  });
  group('NotificationScheduleCalculatorImpl - Next Schedule Monthly', () {
    test('should return the next monthly occurrence', () {
      final scheduleDate = DateTime(2026, 10, 15, 10, 30);

      final request = NotificationRequest(
        id: '1',
        title: 'test',
        body: 'test',
        scheduleDate: scheduleDate,
        endDate: null,
        recurrence: NotificationRecurrence.monthly,
      );

      final result = calculator.calculateNextScheduleAfter(
        request,
        scheduleDate,
      );

      expect(result, DateTime(2026, 11, 15, 10, 30));
    });
  });

  group(  'NotificationScheduleCalculatorImpl - Next Schedule Monthly Critical',
    () {
      test('should handle months with fewer days', () {
        final scheduleDate = DateTime(2026, 1, 31, 10, 30);
        final currentDate = DateTime(2026, 1, 31, 10, 30);

        final request = NotificationRequest(
          id: '1',
          title: 'test',
          body: 'test',
          scheduleDate: scheduleDate,
          endDate: null,
          recurrence: NotificationRecurrence.monthly,
        );

        final result = calculator.calculateNextScheduleAfter(
          request,
          currentDate,
        );

        expect(result, DateTime(2026, 2, 28, 10, 30));
      });
    },
  );

  group('NotificationScheduleCalculatorImpl - Next Schedule Monthly Year Change',
    () {
      test('should handle December to January correctly', () {
        final scheduleDate = DateTime(2026, 12, 31, 10, 30);

        final request = NotificationRequest(
          id: '1',
          title: 'test',
          body: 'test',
          scheduleDate: scheduleDate,
          endDate: null,
          recurrence: NotificationRecurrence.monthly,
        );

        final result = calculator.calculateNextScheduleAfter(
          request,
          scheduleDate,
        );

        expect(result, DateTime(2027, 1, 31, 10, 30));
      });
    },
  );
  group('NotificationScheduleCalculatorImpl - Next Schedule Yearly', () {
    test('should return the next yearly occurrence', () {
      final scheduleDate = DateTime(2026, 10, 5, 10, 30);

      final request = NotificationRequest(
        id: '1',
        title: 'test',
        body: 'test',
        scheduleDate: scheduleDate,
        endDate: null,
        recurrence: NotificationRecurrence.yearly,
      );

      final result = calculator.calculateNextScheduleAfter(
        request,
        scheduleDate,
      );

      expect(result, DateTime(2027, 10, 5, 10, 30));
    });
  });

  group('NotificationScheduleCalculatorImpl - Next Schedule Yearly Leap', () {
    test('should handle February 29 correctly', () {
      final scheduleDate = DateTime(2024, 2, 29, 10, 30);

      final request = NotificationRequest(
        id: '1',
        title: 'test',
        body: 'test',
        scheduleDate: scheduleDate,
        endDate: null,
        recurrence: NotificationRecurrence.yearly,
      );

      final result = calculator.calculateNextScheduleAfter(
        request,
        scheduleDate,
      );

      expect(result, DateTime(2025, 2, 28, 10, 30));
    });
  });
}
