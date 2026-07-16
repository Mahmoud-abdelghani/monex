import 'package:monex/features/auth/domain/repository/auth_reapository.dart';

class Logout {
  AuthReapository authReapository;

  Logout({required this.authReapository});

  Future<void> call() {
    return authReapository.logout();
  }
}