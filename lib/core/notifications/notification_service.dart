import 'package:monex/core/notifications/notification_request.dart';

abstract class NotificationService {
  Future<void> initialize();
  Future<bool> requestPermission();
  Future<bool> isNotificationsEnabled();
  Future<void> showNotification(NotificationRequest request);
  Future<void> scheduleNotification(NotificationRequest request);
  Future<void> cancelNotification(String id);
  Future<void> cancelAllNotifications();
}
