import 'package:monex/features/auth/domain/entities/password.dart';
import 'package:monex/features/auth/domain/repository/auth_reapository.dart';

class ChangePassword {
  AuthReapository authReapository;
  ChangePassword({required this.authReapository});

  Future<void> call({required Password newPassword}) {
    return authReapository.updatePassword(newPassword: newPassword);
  }
}