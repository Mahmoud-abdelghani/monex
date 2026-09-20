import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/auth/domain/entities/user_entity.dart';
import 'package:monex/features/auth/domain/usecase/register.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.registerUseCase) : super(RegisterInitial());
  final RegisterUseCase registerUseCase;

  Future<void> register({
    required String userEmail,
    required String userPassword,
    required String userUsername,
  }) async {
    emit(RegisterLoading());
    final result = await registerUseCase(
      userEmail: userEmail,
      userPassword: userPassword,
      userUsername: userUsername,
    );
    result.fold(
      (failure) => emit(RegisterFailure(failure.message)),
      (userEntity) => emit(RegisterSuccess(userEntity)),
    );
  }
  
}
