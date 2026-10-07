import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/core/notifications/enums/notification_recurrence.dart';

extension ReminderNotificationMapper on ContributionPeriod {
  NotificationRecurrence toNotificationRecurrence() {
    switch (this) {
      case ContributionPeriod.none:
        return NotificationRecurrence.none;
      case ContributionPeriod.daily:
        return NotificationRecurrence.daily;
      case ContributionPeriod.weekly:
        return NotificationRecurrence.weekly;
      case ContributionPeriod.monthly:
        return NotificationRecurrence.monthly;
      case ContributionPeriod.yearly:
        return NotificationRecurrence.yearly;
    }
  }
}
