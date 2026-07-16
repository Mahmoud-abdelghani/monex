import 'package:monex/features/auth/domain/entities/eamil.dart';
import 'package:monex/features/auth/domain/repository/auth_reapository.dart';

class SendEmailResetPassword {
  AuthReapository authenticationRepository;
  SendEmailResetPassword({required this.authenticationRepository});



  Future<void> call({required Email email}) {
    return authenticationRepository.sendEmailForPasswordReset(email: email);
  }
}