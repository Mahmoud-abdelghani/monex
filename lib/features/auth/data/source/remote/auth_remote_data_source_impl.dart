import 'package:monex/features/auth/data/source/remote/auth_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<User> login({required String email, required String password}) async {
    final result = await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return result.user!;
  }

  @override
  Future<void> logout() async {
    await supabaseClient.auth.signOut();
  }

  @override
  Future<User> register({
    required String email,
    required String password,
    required String userName,
  }) async {
    final result = await supabaseClient.auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: 'com.monex://login-callback',
      data: {'name': userName},
    );
    return result.user!;
  }

  @override
  Future<void> sendEmailForPasswordReset({required String email}) async {
    await supabaseClient.auth.resetPasswordForEmail(
      email,
      redirectTo: 'com.monex://reset-password',
    );
  }

  @override
  Future<User> updatePassword({required String newPassword}) async {
    final result = await supabaseClient.auth.updateUser(
      UserAttributes(password: newPassword),
    );
    return result.user!;
  }

  @override
  Future<User> verifyEmail({
    required String email,
    required String password,
  }) async {
    final result = await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return result.user!;
  }

  @override
  Future<User> loginWithGoogle() async {
    await supabaseClient.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'com.monex://login-callback',
    );
    await supabaseClient.auth.onAuthStateChange.firstWhere(
      (element) => element.session != null,
    );

    return supabaseClient.auth.currentUser!;
  }
}
