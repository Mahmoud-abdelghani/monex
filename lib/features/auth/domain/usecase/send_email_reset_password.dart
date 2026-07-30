import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/auth/domain/repository/auth_repository.dart';
import 'package:monex/features/auth/domain/value_objects/email.dart';

class SendEmailResetPassword {
  AuthRepository authenticationRepository;
  SendEmailResetPassword({required this.authenticationRepository});



  Future<Either<Failure, void>> call({required String userEmail}) {
    final email = Email(userEmail);
    return authenticationRepository.sendEmailForPasswordReset(email: email);
  }
}