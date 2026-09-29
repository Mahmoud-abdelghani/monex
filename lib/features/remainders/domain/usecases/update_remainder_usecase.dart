import 'package:fpdart/fpdart.dart';
import 'package:monex/core/enums/contribution_period.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/remainders/domain/entities/remainder_entity.dart';
import 'package:monex/features/remainders/domain/repository/remainder_repository.dart';

class UpdateRemainderUsecase {
  final RemainderRepository remainderRepository;

  UpdateRemainderUsecase(this.remainderRepository);

  Future<Either<Failure, void>> call({
    required String id,
    required String title,
    required double amount,
    required ContributionPeriod frequency,
    required DateTime deadline,
  }) => remainderRepository.updateRemainder(
    RemainderEntity(
      id: id,
      title: title,
      amount: amount,
      frequency: frequency,
      deadline: deadline,
    ),
  );
}
