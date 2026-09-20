import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/auth/domain/entities/user_entity.dart';
import 'package:monex/features/auth/domain/value_objects/email.dart';
import 'package:monex/features/auth/domain/value_objects/password.dart';
import 'package:monex/features/auth/domain/value_objects/username.dart';

abstract class AuthRepository {
   Future<Either<Failure, UserEntity>>  loginWithEmailPassword({
    required Email email,
    required Password password,
  });

  Future<Either<Failure, UserEntity>> register({
    required Email email,
    required Password password,
    required Username username,
  });

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserEntity>> updatePassword({required Password newPassword});

  Future<Either<Failure, void>> sendEmailForPasswordReset({required Email email});

  Future<Either<Failure, UserEntity>> verifyEmail({required Email email, required Password password});

  Future<Either<Failure, UserEntity>> loginWithGoogle();
}
