import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/repository/pending_operation_repository.dart';

class RetryOperationUsecase {
  final PendingOperationRepository repository;

  RetryOperationUsecase(this.repository);

  Future<Either<Failure, bool>> call(String operationId) =>
      repository.resetRetry(operationId);
}
