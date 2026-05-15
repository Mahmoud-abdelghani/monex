import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/services/supabase_service.dart';
import 'package:monex/features/auth/cubit/authentication_cubit.dart';
import 'package:monex/features/auth/screens/forgot_password_screen.dart';
import 'package:monex/features/auth/screens/login_screen.dart';
import 'package:monex/features/auth/screens/password_updated_screen.dart';
import 'package:monex/features/auth/screens/register_screen.dart';
import 'package:monex/features/auth/screens/reset_password_screen.dart';
import 'package:monex/features/auth/screens/verification_screen.dart';
import 'package:monex/features/home/screens/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await Supabase.initialize(
    url: 'https://cnuoluqzsdycntejglgr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNudW9sdXF6c2R5Y250ZWpnbGdyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc4MzQwNjIsImV4cCI6MjA5MzQxMDA2Mn0.XoLJZtrY-QgvanX_EdhTojo4jqWHYKRgbxHexFSbwZM',
  );
  SupabaseService.supabase.auth.onAuthStateChange.listen((data) {
    try {
      final event = data.event;

      if (event == AuthChangeEvent.passwordRecovery) {
        navigatorKey.currentState?.pushNamed(ResetPasswordScreen.routeName);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthenticationCubit())],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          RegisterScreen.routeName: (context) => const RegisterScreen(),
          ForgotPasswordScreen.routeName: (context) =>
              const ForgotPasswordScreen(),
          ResetPasswordScreen.routeName: (context) =>
              const ResetPasswordScreen(),
          PasswordUpdatedScreen.routeName: (context) =>
              const PasswordUpdatedScreen(),
          EmailVerificationScreen.routeName: (context) =>
              const EmailVerificationScreen(),

          HomeScreen.routeName: (context) => const HomeScreen(),
        },

        initialRoute: SupabaseService.supabase.auth.currentUser != null
            ? HomeScreen.routeName
            : LoginScreen.routeName,
      ),
    );
  }
}
