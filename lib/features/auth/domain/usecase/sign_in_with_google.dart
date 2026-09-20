import 'package:fpdart/fpdart.dart';
import 'package:monex/core/error/failure.dart';
import 'package:monex/features/auth/domain/entities/user_entity.dart';
import 'package:monex/features/auth/domain/repository/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository authRepository;
  SignInWithGoogleUseCase(this.authRepository);

  Future<Either<Failure, UserEntity>> call() {
    return authRepository.loginWithGoogle();
  }
}