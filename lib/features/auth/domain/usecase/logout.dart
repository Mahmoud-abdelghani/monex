import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/auth/domain/repository/auth_repository.dart';

class LogoutUseCase {
  AuthRepository authReapository;

  LogoutUseCase(this.authReapository);

  Future<Either<Failure, void>> call() {
    return authReapository.logout();
  }
}