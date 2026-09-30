import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/reminders/domain/entities/reminder_entity.dart';
import 'package:monex/features/reminders/domain/repository/reminder_repository.dart';

class GetReminderByIdUsecase {
  final ReminderRepository reminderRepository;
  GetReminderByIdUsecase(this.reminderRepository);

  Future<Either<Failure, ReminderEntity?>> call(String id) => reminderRepository.getReminderById(id);
}