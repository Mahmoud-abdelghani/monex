import 'package:monex/core/notifications/enums/notification_recurrence.dart';

class NotificationRequest {
  final String id;
  final String title;
  final String body;
  final NotificationRecurrence recurrence;
  final DateTime scheduleDate;
  DateTime? endDate;

  NotificationRequest({
    required this.id,
    required this.title,
    required this.body,
    required this.scheduleDate,
    required this.recurrence,
    this.endDate,
  });
}
