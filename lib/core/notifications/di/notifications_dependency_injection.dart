import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:monex/core/di/injection_container.dart';
import 'package:monex/core/notifications/local_notification_service.dart';
import 'package:monex/core/notifications/local_timezone_service.dart';
import 'package:monex/core/notifications/notification_service.dart';
import 'package:monex/core/notifications/timezone_service.dart';

void registerNotificationsDependencies() {
  getIt.registerLazySingleton<TimezoneService>(() => LocalTimezoneService());
  getIt.registerLazySingleton<FlutterLocalNotificationsPlugin>(
    () => FlutterLocalNotificationsPlugin(),
  );
  getIt.registerLazySingleton<NotificationService>(
    () => LocalNotificationService(
      getIt<FlutterLocalNotificationsPlugin>(),
      timezoneService: getIt<TimezoneService>(),
    ),
  );
}
