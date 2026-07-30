import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/error/failures/server_failure.dart';
import 'package:monex/features/auth/data/source/remote/auth_remote_data_source.dart';
import 'package:monex/features/auth/domain/repository/auth_repository.dart';
import 'package:monex/features/auth/domain/entities/user_entity.dart';
import 'package:monex/features/auth/domain/value_objects/email.dart';
import 'package:monex/features/auth/domain/value_objects/password.dart';
import 'package:monex/features/auth/domain/value_objects/username.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, UserEntity>> loginWithEmailPassword({
    required Email email,
    required Password password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        email: email.value,
        password: password.value,
      );
      return Right(UserEntity(id: user.id, email: user.email!));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required Email email,
    required Password password,
    required Username username,
  }) async {
    try {
      final user = await remoteDataSource.register(
        email: email.value,
        password: password.value,
        userName: username.value,
      );
      return Right(UserEntity(id: user.id, email: user.email!));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendEmailForPasswordReset({
    required Email email,
  }) async {
    try {
      await remoteDataSource.sendEmailForPasswordReset(email: email.value);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updatePassword({
    required Password newPassword,
  }) async {
    try {
      final user = await remoteDataSource.updatePassword(
        newPassword: newPassword.value,
      );
      return Right(UserEntity(id: user.id, email: user.email!));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyEmail({
    required Email email,
    required Password password,
  }) async {
    try {
      final user = await remoteDataSource.verifyEmail(
        email: email.value,
        password: password.value,
      );
      return Right(UserEntity(id: user.id, email: user.email!));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
