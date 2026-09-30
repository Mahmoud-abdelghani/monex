import 'package:fpdart/fpdart.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';
import 'package:monex/features/reminders/domain/repository/reminder_repository.dart';

class UpdateReminderUsecase {
  final ReminderRepository reminderRepository;

  UpdateReminderUsecase(this.reminderRepository);

  Future<Either<Failure, void>> call({
    required String id,
    required String title,
    required double amount,
    required ContributionPeriod frequency,
    required DateTime deadline,
  }) => reminderRepository.updateReminder(
    ReminderEntity(
      id: id,
      title: title,
      amount: amount,
      frequency: frequency,
      deadline: deadline,
    ),
  );
}
