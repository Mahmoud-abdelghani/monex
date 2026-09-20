import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/error/failures/validation_failure.dart';
import 'package:monex/features/auth/domain/repository/auth_repository.dart';
import 'package:monex/features/auth/domain/entities/user_entity.dart';
import 'package:monex/features/auth/domain/value_objects/password.dart';

class ChangePasswordUseCase {
  AuthRepository authReapository;
  ChangePasswordUseCase( this.authReapository);

  Future<Either<Failure, UserEntity>> call({required String userNewPassword})async {
    try {
      final newPassword = Password(userNewPassword);
      return await authReapository.updatePassword(newPassword: newPassword);
    } on ArgumentError catch (e) {
      return Left(ValidationFailure(e.message.toString()));
    }
  }
}
