import 'package:monex/core/notifications/notification_request.dart';

abstract class NotificationScheduleCalculator {
  List<DateTime> calculateSchedules(NotificationRequest request);
DateTime? calculateNextScheduleAfter(
    NotificationRequest request,
    DateTime date,
  );
}
