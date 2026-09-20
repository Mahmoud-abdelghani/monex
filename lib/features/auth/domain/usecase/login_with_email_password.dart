
import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/error/failures/validation_failure.dart';
import 'package:monex/features/auth/domain/repository/auth_repository.dart';
import 'package:monex/features/auth/domain/entities/user_entity.dart';
import 'package:monex/features/auth/domain/value_objects/email.dart';
import 'package:monex/features/auth/domain/value_objects/password.dart';

class LoginWithEmailPasswordUseCase {
  AuthRepository authReapository;

  LoginWithEmailPasswordUseCase(this.authReapository);

  Future<Either<Failure, UserEntity>> call({
    required String  userEmail,
    required String  userPassword,
  }) async {
    try {
      final email = Email(userEmail);
      final password = Password(userPassword);
      return await authReapository.loginWithEmailPassword(email: email, password: password);
    } on ArgumentError catch (e) {
      return Left(
        ValidationFailure(e.message.toString()),
      );
    }
  }
}
