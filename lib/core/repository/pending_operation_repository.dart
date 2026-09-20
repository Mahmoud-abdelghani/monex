import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';

abstract class PendingOperationRepository {
  Future<Either<Failure, bool>> resetRetry(String operationId);
}