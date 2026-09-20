import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/core/error/failures/validation_failure.dart';
import 'package:monex/features/auth/domain/repository/auth_repository.dart';
import 'package:monex/features/auth/domain/value_objects/email.dart';

class SendEmailResetPasswordUseCase {
  AuthRepository authRepository;
  SendEmailResetPasswordUseCase(this.authRepository);

  Future<Either<Failure, void>> call({required String userEmail}) async {
    try {
      final email = Email(userEmail);
      return await authRepository.sendEmailForPasswordReset(email: email);
    } on ArgumentError catch (e) {
      return Left(ValidationFailure(e.message.toString()));
    }
  }
}
