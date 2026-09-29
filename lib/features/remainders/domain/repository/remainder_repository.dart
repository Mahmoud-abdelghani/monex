import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/remainders/domain/entities/remainder_entity.dart';

abstract class RemainderRepository {
  Future<Either<Failure, void>> addRemainder(RemainderEntity remainder);

  Future<Either<Failure, void>> updateRemainder(RemainderEntity remainder);

  Future<Either<Failure, void>> deleteRemainder(String id);

  Stream<Either<Failure, List<RemainderEntity>>> watchRemainders();

  Future<Either<Failure, RemainderEntity?>> getRemainderById(String id);
}
