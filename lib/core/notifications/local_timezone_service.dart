import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:monex/core/notifications/timezone_service.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalTimezoneService implements TimezoneService {
  @override
  Future<void> initialize() async {
    tz.initializeTimeZones();
    final timezoneInfo = await FlutterTimezone.getLocalTimezone();
    final local = tz.getLocation(timezoneInfo.identifier);
    tz.setLocalLocation(local);
  }
}
