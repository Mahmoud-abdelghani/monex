import 'package:monex/features/auth/domain/entities/eamil.dart';
import 'package:monex/features/auth/domain/entities/password.dart';
import 'package:monex/features/auth/domain/repository/auth_reapository.dart';

class VerifyEmail {
  AuthReapository authReapository;

  VerifyEmail({required this.authReapository});

  Future<void> call({
    required Email email,
    required Password password,
  }) {
    return authReapository.verifyEmail(email: email, password: password);
  }
}