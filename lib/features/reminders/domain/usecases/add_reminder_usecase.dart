import 'package:fpdart/fpdart.dart';
import 'package:monex/core/di/uuid_container.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/core/error/error_message_extraction.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/error/failures/notification_failure.dart';
import 'package:monex/core/notifications/enums/notification_recurrence.dart';
import 'package:monex/core/notifications/notification_request.dart';
import 'package:monex/core/notifications/notification_service.dart';
import 'package:monex/core/notifications/recurrence/notification_schedule_calculator.dart';
import 'package:monex/features/reminders/data/mappers/reminder_notification_mapper.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';
import 'package:monex/features/reminders/domain/repository/reminder_repository.dart';

class AddReminderUsecase {
  final ReminderRepository reminderRepository;
  final NotificationService notificationService;
  final NotificationScheduleCalculator notificationScheduleCalculator;

  AddReminderUsecase({
    required this.reminderRepository,
    required this.notificationService,
    required this.notificationScheduleCalculator,
  });

  Future<Either<Failure, void>> call({
    required String title,
    required double amount,
    required ContributionPeriod frequency,
    required DateTime scheduleDate,
    required DateTime deadline,
  }) async {
    final String id = uuid.v4();
    final result = await reminderRepository.addReminder(
      ReminderEntity(
        id: id,
        title: title,
        amount: amount,
        frequency: frequency,
        deadline: deadline,
        scheduleDate: scheduleDate,
      ),
    );
    if (result.isLeft()) return result;
    final scheduledNotificationIds = <String>[];
    try {
      final notificationRequest = NotificationRequest(
        id: id,
        title: title,
        body: 'Reminder for $title amount $amount',
        scheduleDate: scheduleDate,
        recurrence: frequency.toNotificationRecurrence(),
        endDate: deadline,
      );

      final schedules = notificationScheduleCalculator.calculateSchedules(
        notificationRequest,
      );
      List<NotificationRequest> notificationRequests = [];

      for (var schedule in schedules) {
        final occurrenceId = '$id-${schedule.toIso8601String()}';
        final notificationRequest = NotificationRequest(
          id: occurrenceId,
          title: title,
          body: 'Reminder for $title amount $amount',
          scheduleDate: schedule,
          recurrence: frequency.toNotificationRecurrence(),
          endDate: deadline,
        );
        notificationRequests.add(notificationRequest);
      }
      for (final request in notificationRequests) {
        await notificationService.scheduleNotification(request);
        scheduledNotificationIds.add(request.id);
      }
    } on Exception catch (e) {
      for (final notificationId in scheduledNotificationIds) {
        try {
          await notificationService.cancelNotification(notificationId);
        } on Exception {
          // Best effort cleanup.
        }
      }
      return Left(NotificationFailure(extractErrorMessage(e)));
    }
    return right(null);
  }
}
