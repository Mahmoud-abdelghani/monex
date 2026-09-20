import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/auth/domain/entities/user_entity.dart';
import 'package:monex/features/auth/domain/usecase/sign_in_with_google.dart';

part 'sign_in_with_google_state.dart';

class SignInWithGoogleCubit extends Cubit<SignInWithGoogleState> {
  SignInWithGoogleCubit(this.signInWithGoogleUseCase)
    : super(SignInWithGoogleInitial());
  final SignInWithGoogleUseCase signInWithGoogleUseCase;

  Future<void> signInWithGoogle() async {
    emit(SignInWithGoogleLoading());
    final failureOrUser = await signInWithGoogleUseCase.call();
    failureOrUser.fold(
      (failure) => emit(SignInWithGoogleFailure(message: failure.message)),
      (user) => emit(SignInWithGoogleSuccess(userEntity: user)),
    );
  }
}
