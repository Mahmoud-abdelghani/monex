import 'package:monex/features/auth/domain/entities/eamil.dart';
import 'package:monex/features/auth/domain/entities/password.dart';
import 'package:monex/features/auth/domain/entities/username.dart';

abstract class AuthReapository {
  Future<void> loginWithEmailPassword({
    required Email email,
    required Password password,
  });

  Future<void> register({
    required Email email,
    required Password password,
    required Username username,
  });

  Future<void> logout();

  Future<void> updatePassword({required Password newPassword});

  Future<void> sendEmailForPasswordReset({required Email email});

  Future<void> verifyEmail({
    required Email email,
    required Password password,
  });
}
