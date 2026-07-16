import 'package:monex/features/auth/domain/entities/eamil.dart';
import 'package:monex/features/auth/domain/entities/password.dart';
import 'package:monex/features/auth/domain/entities/username.dart';
import 'package:monex/features/auth/domain/repository/auth_reapository.dart';

class Register {
  final AuthReapository authReapository;

  Register({required this.authReapository});

  Future<void> call({
    required Email email,
    required Password password,
    required Username username,
  }) {
    return authReapository.register(
      email: email,
      password: password,
      username: username,
    );
  }
  
}