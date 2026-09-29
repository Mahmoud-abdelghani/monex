import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/remainders/domain/repository/remainder_repository.dart';

class DeleteRemainderUsecase {
  final RemainderRepository remainderRepository;

  DeleteRemainderUsecase(this.remainderRepository);

  Future<Either<Failure, void>> call(String id) =>  remainderRepository.deleteRemainder(id);
}