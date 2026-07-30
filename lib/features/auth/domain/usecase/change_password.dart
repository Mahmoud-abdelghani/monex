import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/auth/domain/repository/auth_repository.dart';
import 'package:monex/features/auth/domain/entities/user_entity.dart';
import 'package:monex/features/auth/domain/value_objects/password.dart';

class ChangePassword {
  AuthRepository authReapository;
  ChangePassword({required this.authReapository});

  Future<Either<Failure, UserEntity>> call({required String userNewPassword}) {
    final newPassword = Password(userNewPassword);
    return authReapository.updatePassword(newPassword: newPassword);
  }
}
