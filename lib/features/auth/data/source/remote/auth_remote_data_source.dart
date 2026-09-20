import 'package:monex/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<User> login({required String email, required String password});
  Future<User> verifyEmail({required String email, required String password});
  Future<void> logout();
  Future<User> register({required String email, required String password,required String userName});
  Future<void> sendEmailForPasswordReset({required String email});
  Future<User> updatePassword({required String newPassword});
  Future<User> loginWithGoogle();
}
