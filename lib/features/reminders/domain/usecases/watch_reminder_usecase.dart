import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';
import 'package:monex/features/reminders/domain/repository/reminder_repository.dart';

class WatchReminderUsecase {
  final ReminderRepository reminderRepository;
  WatchReminderUsecase(this.reminderRepository);

  Stream<Either<Failure, List<ReminderEntity>>> call() => reminderRepository.watchReminders();
}