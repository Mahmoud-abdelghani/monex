import 'package:fpdart/fpdart.dart';
import 'package:monex/core/di/uuid_container.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/remainders/domain/entities/remainder_entity.dart';
import 'package:monex/features/remainders/domain/repository/remainder_repository.dart';

class AddRemainderUsecase {
  final RemainderRepository remainderRepository;

  AddRemainderUsecase(this.remainderRepository);

  Future<Either<Failure, void>> call({
    required String title,
    required double amount,
    required ContributionPeriod frequency,
    required DateTime deadline,
  }) => remainderRepository.addRemainder(
    RemainderEntity(
      id: uuid.v4(),
      title: title,
      amount: amount,
      frequency: frequency,
      deadline: deadline,
    ),
  );
}
