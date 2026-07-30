
import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/auth/domain/repository/auth_repository.dart';
import 'package:monex/features/auth/domain/entities/user_entity.dart';
import 'package:monex/features/auth/domain/value_objects/email.dart';
import 'package:monex/features/auth/domain/value_objects/password.dart';
import 'package:monex/features/auth/domain/value_objects/username.dart';

class Register {
  final AuthRepository authReapository;

  Register({required this.authReapository});

  Future<Either<Failure, UserEntity>> call({
    required String  userEmail,
    required String userPassword,
    required String userUsername,
  }) {
    final email = Email(userEmail);
    final password = Password(  userPassword);
    final username = Username( userUsername);
    return authReapository.register(
      email: email,
      password: password,
      username: username,
    );
  }
  
}