import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/remainders/domain/entities/remainder_entity.dart';
import 'package:monex/features/remainders/domain/repository/remainder_repository.dart';

class GetRemainderByIdUsecase {
  final RemainderRepository remainderRepository;
  GetRemainderByIdUsecase(this.remainderRepository);

  Future<Either<Failure, RemainderEntity?>> call(String id) => remainderRepository.getRemainderById(id);
}