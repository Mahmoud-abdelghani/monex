import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/auth/domain/repository/auth_repository.dart';
import 'package:monex/features/auth/domain/entities/user_entity.dart';
import 'package:monex/features/auth/domain/value_objects/email.dart';
import 'package:monex/features/auth/domain/value_objects/password.dart';

class VerifyEmail {
  AuthRepository authReapository;

  VerifyEmail({required this.authReapository});

  Future<Either<Failure, UserEntity>> call({
    required String  userEmail,
    required String  puserPassword,
  }) {
    final email = Email(userEmail);
    final password = Password(userEmail);
    return authReapository.verifyEmail(email: email, password: password);
  }
}
