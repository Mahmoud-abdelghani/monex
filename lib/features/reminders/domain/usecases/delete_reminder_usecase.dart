import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/reminders/domain/repository/reminder_repository.dart';

class DeleteReminderUsecase {
  final ReminderRepository reminderRepository;

  DeleteReminderUsecase(this.reminderRepository);

  Future<Either<Failure, void>> call(String id) =>  reminderRepository.deleteReminder(id);
}