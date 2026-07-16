import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/services/supabase_service.dart';
import 'package:monex/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:monex/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:monex/features/auth/presentation/screens/login_screen.dart';
import 'package:monex/features/auth/presentation/screens/password_updated_screen.dart';
import 'package:monex/features/auth/presentation/screens/register_screen.dart';
import 'package:monex/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:monex/features/auth/presentation/screens/verification_screen.dart';
import 'package:monex/features/home/screens/home_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://cnuoluqzsdycntejglgr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNudW9sdXF6c2R5Y250ZWpnbGdyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc4MzQwNjIsImV4cCI6MjA5MzQxMDA2Mn0.XoLJZtrY-QgvanX_EdhTojo4jqWHYKRgbxHexFSbwZM',
  );

  SupabaseService.supabase.auth.onAuthStateChange.listen((data) {
    try {
      final event = data.event;
      final session = data.session;

      /// Password Recovery Flow
      if (event == AuthChangeEvent.passwordRecovery) {
        navigatorKey.currentState?.pushNamed(ResetPasswordScreen.routeName);
      }

      /// Email Verification / OAuth Login Flow
      if (event == AuthChangeEvent.signedIn && session != null) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          HomeScreen.routeName,
          (route) => false,
        );
      }

      /// Logout Flow
      if (event == AuthChangeEvent.signedOut) {
        navigatorKey.currentState?.pushNamedAndRemoveUntil(
          LoginScreen.routeName,
          (route) => false,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Build a smooth fade transition for auth screens.
  static Route<dynamic> _fadeRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 260),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => AuthenticationCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case LoginScreen.routeName:
              return _fadeRoute(const LoginScreen());
            case RegisterScreen.routeName:
              return _fadeRoute(const RegisterScreen());
            case ForgotPasswordScreen.routeName:
              return _fadeRoute(const ForgotPasswordScreen());
            case ResetPasswordScreen.routeName:
              return _fadeRoute(const ResetPasswordScreen());
            case PasswordUpdatedScreen.routeName:
              return _fadeRoute(const PasswordUpdatedScreen());
            case EmailVerificationScreen.routeName:
              return _fadeRoute(const EmailVerificationScreen());
            case HomeScreen.routeName:
              return _fadeRoute(const HomeScreen());
            default:
              return null;
          }
        },
        initialRoute: SupabaseService.supabase.auth.currentUser != null
            ? HomeScreen.routeName
            : LoginScreen.routeName,
      ),
    );
  }
}
