import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:monex/core/notifications/notification_id_mapper.dart';
import 'package:monex/core/notifications/notification_request.dart';
import 'package:monex/core/notifications/notification_service.dart';
import 'package:monex/core/notifications/timezone_service.dart';

import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService implements NotificationService {
  final FlutterLocalNotificationsPlugin plugin;
  final TimezoneService timezoneService;

  LocalNotificationService(this.plugin, {required this.timezoneService});

  static const String _channelId = 'monex_notification';
  static const String _channelName = 'Monex Notification';
  static const String _channelDescription = 'Notifications from Monex';

  static const AndroidNotificationChannel _androidNotificationChannel =
      AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDescription,
        importance: Importance.high,
      );

  @override
  Future<void> cancelAllNotifications() {
    return plugin.cancelAll();
  }

  @override
  Future<void> cancelNotification(String id) {
    final notificationId = NotificationIdMapper.map(id);

    return plugin.cancel(id: notificationId);
  }

  @override
  Future<void> initialize() async {
    await timezoneService.initialize();

    final androidInitializationSettings = const AndroidInitializationSettings(
      '@drawable/ic_stat_monex',
    );
    final darwinInitializationSettings = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    await plugin.initialize(settings: initializationSettings);

    await _createNotificationChannel();
  }

  @override
  Future<bool> requestPermission() async {
    final androidPlugin = plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final iosPlugin = plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    final isAndroidGranted = await androidPlugin
        ?.requestNotificationsPermission();

    final isIosGranted = await iosPlugin?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    return isAndroidGranted ?? isIosGranted ?? false;
  }

  @override
  Future<void> scheduleNotification(NotificationRequest request) async {
    if (request.scheduleDate.isBefore(tz.TZDateTime.now(tz.local))) {
      throw Exception(
        'Cannot schedule notification in the past.',
      );
    }
    final notificationId = NotificationIdMapper.map(request.id);
    final notificationDetails = _notificationDetails();
    final scheduledDate = tz.TZDateTime.from(request.scheduleDate, tz.local);
    

    await plugin.zonedSchedule(
      id: notificationId,
      title: request.title,
      body: request.body,
      notificationDetails: notificationDetails,
      scheduledDate: scheduledDate,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  @override
  Future<void> showNotification(NotificationRequest request) async {
    final notificationId = NotificationIdMapper.map(request.id);
    final notificationDetails = _notificationDetails();

    await plugin.show(
      id: notificationId,
      title: request.title,
      body: request.body,
      notificationDetails: notificationDetails,
    );
  }

  Future<void> _createNotificationChannel() async {
    final androidPlugin = plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidPlugin?.createNotificationChannel(_androidNotificationChannel);
  }

  NotificationDetails _notificationDetails() {
    final androidNotificationDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
    );

    final darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
  }

  @override
  Future<bool> areNotificationsEnabled() async {
    final androidPlugin = plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final androidEnabled = await androidPlugin?.areNotificationsEnabled();
    final iosPlugin = plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    final iosEnabled = (await iosPlugin?.checkPermissions())?.isEnabled;
    return androidEnabled ?? iosEnabled ?? false;
  }
}
