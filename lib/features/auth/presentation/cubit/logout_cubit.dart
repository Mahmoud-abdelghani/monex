import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/features/auth/domain/entities/user_entity.dart';
import 'package:monex/features/auth/domain/usecase/logout.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this.logoutUseCase
  ) : super(LogoutInitial());
  final LogoutUseCase logoutUseCase;

  Future<void> logout()async{
    final result = await logoutUseCase();
    result.fold(
      (failure) => emit(LogoutFailure(failure.message)),
      (logout) => emit(LogoutSuccess('Logged out successfully')),
    );
    
  }
}
