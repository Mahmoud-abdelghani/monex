import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/remainders/domain/entities/remainder_entity.dart';
import 'package:monex/features/remainders/domain/repository/remainder_repository.dart';

class WatchRemainderUsecase {
  final RemainderRepository remainderRepository;
  WatchRemainderUsecase(this.remainderRepository);

  Stream<Either<Failure, List<RemainderEntity>>> call() => remainderRepository.watchRemainders();
}