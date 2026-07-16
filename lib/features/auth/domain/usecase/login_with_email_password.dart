import 'package:monex/features/auth/domain/entities/eamil.dart';
import 'package:monex/features/auth/domain/entities/password.dart';
import 'package:monex/features/auth/domain/repository/auth_reapository.dart';

class LoginWithEmailPassword {
  AuthReapository repo;

  LoginWithEmailPassword(this.repo);

  Future<void> call({
    required Email email,
    required Password password,
  }) {
    return repo.loginWithEmailPassword(email: email, password: password);
  }
}
