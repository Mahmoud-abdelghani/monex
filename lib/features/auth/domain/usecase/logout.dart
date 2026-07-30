import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/auth/domain/repository/auth_repository.dart';

class Logout {
  AuthRepository authReapository;

  Logout({required this.authReapository});

  Future<Either<Failure, void>> call() {
    return authReapository.logout();
  }
}