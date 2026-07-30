
import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/auth/domain/repository/auth_repository.dart';
import 'package:monex/features/auth/domain/entities/user_entity.dart';
import 'package:monex/features/auth/domain/value_objects/email.dart';
import 'package:monex/features/auth/domain/value_objects/password.dart';

class LoginWithEmailPassword {
  AuthRepository repo;

  LoginWithEmailPassword(this.repo);

  Future<Either<Failure, UserEntity>> call({
    required String  userEmail,
    required String  userPassword,
  }) {
    final email = Email(userEmail);
    final password = Password(userPassword);
    return repo.loginWithEmailPassword(email: email, password: password);
  }
}
