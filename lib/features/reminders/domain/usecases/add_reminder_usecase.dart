import 'package:fpdart/fpdart.dart';
import 'package:monex/core/di/uuid_container.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';
import 'package:monex/features/reminders/domain/repository/reminder_repository.dart';

class AddReminderUsecase {
  final ReminderRepository reminderRepository;

  AddReminderUsecase(this.reminderRepository);

  Future<Either<Failure, void>> call({
    required String title,
    required double amount,
    required ContributionPeriod frequency,
    required DateTime deadline,
  }) => reminderRepository.addReminder(
    ReminderEntity(
      id: uuid.v4(),
      title: title,
      amount: amount,
      frequency: frequency,
      deadline: deadline,
    ),
  );
}
