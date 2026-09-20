import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/error_message_extraction.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/error/failures/local_storage_failure.dart';
import 'package:monex/core/error/failures/server_failure.dart';
import 'package:monex/core/local/database/datasources/pending_operations_local_data_source.dart';
import 'package:monex/core/repository/pending_operation_repository.dart';

class PendingOperationRepositoryImpl implements PendingOperationRepository{
  final PendingOperationsLocalDataSource pendingOperationsLocalDataSource;

  PendingOperationRepositoryImpl( this.pendingOperationsLocalDataSource);

  @override
  Future<Either<Failure, bool>> resetRetry(String operationId) async{
    try {
      return Right(await pendingOperationsLocalDataSource.resetRetry(operationId));
    }on Exception catch (e) {
      return Left(LocalStorageFailure(extractErrorMessage(e)));
    }
  }
}