import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:monex/core/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  Future<void> loginWithGoogle() async {
    try {
      emit(AuthenticationLoginWithGoogleLoading());
      await SupabaseService.supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'com.monex://login-callback',
      );
      await SupabaseService.supabase.auth.onAuthStateChange.firstWhere(
        (element) => element.session != null,
      );

      emit(AuthenticationLoginWithGoogleSuccess());
    } on Exception catch (e) {
      log(e.toString());
      emit(AuthenticationLoginWithGoogleFailure(e.toString()));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      emit(AuthenticationSignUpLoading());
      final AuthResponse res = await SupabaseService.supabase.auth.signUp(
        email: email,
        password: password,
        data: {'username': username},
      );
      final Session? session = res.session;
      final User? user = res.user;
      log(session.toString());
      log(user.toString());

      emit(AuthenticationSignUpSuccess(email: email, password: password));
    } on Exception catch (e) {
      log(e.toString());
      emit(AuthenticationSignUpFailure(e.toString()));
    }
  }

  User? user;
  Future<void> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthenticationSignInLoading());
      final AuthResponse res = await SupabaseService.supabase.auth
          .signInWithPassword(email: email, password: password);

      emit(AuthenticationSignInSuccess());
    } catch (e) {
      log(e.toString());
      emit(AuthenticationSignInFailure(e.toString()));
    }
  }

  Future<void> verifyEmail({
  required String email,
  required String password,
}) async {
  try {
    emit(VerificationLoading());

    final AuthResponse res = await SupabaseService
        .supabase
        .auth
        .signInWithPassword(
          email: email,
          password: password,
        );

    final user = res.user;

    if (user?.emailConfirmedAt != null) {
      emit(VerificationSuccess());
    } else {
      emit(
        VerificationFailure(
          'Please verify your email first',
        ),
      );
    }
  } on AuthException catch (e) {
    emit(VerificationFailure(e.message));
  } catch (e) {
    emit(VerificationFailure(e.toString()));
  }
}

Future<void> sendEmailForPasswordReset({
  required String email,
})async{
  try {
    emit(ForgetPasswordLoading());

    await SupabaseService.supabase.auth.resetPasswordForEmail(
      email,
      redirectTo: 'com.monex://reset-password',
    );

    emit(ForgetPasswordSuccess());
  } on AuthException catch (e) {
    emit(ForgetPasswordFailure(e.message));
  } catch (e) {
    emit(ForgetPasswordFailure(e.toString()));
  }
}

Future<void> updatePassword({
  required String newPassword,
}) async {
  try {
    emit(UpdatePasswordLoading());

    await SupabaseService.supabase.auth.updateUser(
      UserAttributes(
        password: newPassword,
      ),
    );

    emit(UpdatePasswordSuccess());
  } on AuthException catch (e) {
    emit(UpdatePasswordFailure(e.message));
  } catch (e) {
    emit(UpdatePasswordFailure(e.toString()));
  }
}


  Future<void> logout() async {
    try {
      emit(AuthenticationLogoutLoading());
      await SupabaseService.supabase.auth.signOut();

      emit(AuthenticationLogoutSuccess());
    } on Exception catch (e) {
      log(e.toString());
      emit(AuthenticationLogoutFailure(e.toString()));
    }
  }
}
// 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