import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/di/core_dependency_injection.dart';
import 'package:monex/core/di/injection_container.dart';
import 'package:monex/core/sync/sync_coordinator.dart';
import 'package:monex/features/auth/di/auth_depenency_injection.dart';
import 'package:monex/features/auth/presentation/cubit/change_password_cubit.dart';
import 'package:monex/features/auth/presentation/cubit/login_with_email_password_cubit.dart';
import 'package:monex/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:monex/features/auth/presentation/cubit/register_cubit.dart';
import 'package:monex/features/auth/presentation/cubit/send_email_reset_password_cubit.dart';
import 'package:monex/features/auth/presentation/cubit/sign_in_with_google_cubit.dart';
import 'package:monex/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:monex/features/auth/presentation/screens/login_screen.dart';
import 'package:monex/features/auth/presentation/screens/password_updated_screen.dart';
import 'package:monex/features/auth/presentation/screens/register_screen.dart';
import 'package:monex/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:monex/features/auth/presentation/screens/verification_screen.dart';
import 'package:monex/features/expense/di/expense_dependency_injection.dart';
import 'package:monex/features/expense/presentation/cubit/delete_expense_cubit.dart';
import 'package:monex/features/expense/presentation/cubit/update_expense_cubit.dart';
import 'package:monex/features/expense/presentation/cubit/watch_expenses_cubit.dart';
import 'package:monex/features/home/screens/home_screen.dart';
import 'package:monex/features/income/di/incomes_dependency_injection.dart';
import 'package:monex/features/income/presentation/cubit/add_income_cubit.dart';
import 'package:monex/features/income/presentation/cubit/delete_income_cubit.dart';
import 'package:monex/features/income/presentation/cubit/update_income_cubit.dart';
import 'package:monex/features/income/presentation/cubit/watch_incomes_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void setupDependencies() {
  registerCoreDependencies();
  registerAuthDependencies();
  registerExpenseDependencies();
  registerIncomesDependencies();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();

  await Supabase.initialize(
    url: 'https://cnuoluqzsdycntejglgr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNudW9sdXF6c2R5Y250ZWpnbGdyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc4MzQwNjIsImV4cCI6MjA5MzQxMDA2Mn0.XoLJZtrY-QgvanX_EdhTojo4jqWHYKRgbxHexFSbwZM',
  );

  getIt<SupabaseClient>().auth.onAuthStateChange.listen((data) {
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

  final syncCoordinator = getIt<SyncCoordinator>();

  await syncCoordinator.start();

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
      providers: [
        BlocProvider(create: (context) => getIt<RegisterCubit>()),
        BlocProvider(create: (context) => getIt<LoginWithEmailPasswordCubit>()),
        BlocProvider(create: (context) => getIt<SignInWithGoogleCubit>()),
        BlocProvider(create: (context) => getIt<LogoutCubit>()),
        BlocProvider(create: (context) => getIt<SendEmailResetPasswordCubit>()),
        BlocProvider(create: (context) => getIt<ChangePasswordCubit>()),
        BlocProvider(
          create: (context) => getIt<WatchExpensesCubit>()..watchExpenses(),
        ),
        BlocProvider(create: (context) => getIt<UpdateExpenseCubit>()),
        BlocProvider(create: (context) => getIt<DeleteExpenseCubit>()),
        BlocProvider(
          create: (context) => getIt<WatchIncomesCubit>()..watchIncomes(),
        ),
        BlocProvider(create: (context) => getIt<AddIncomeCubit>()),
        BlocProvider(create: (context) => getIt<UpdateIncomeCubit>()),
        BlocProvider(create: (context) => getIt<DeleteIncomeCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        onGenerateRoute: (settings) {
          final routeName = settings.name ?? '';

          // Handle deep links such as:
          // /?code=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
          final uri = Uri.tryParse(routeName);

          if (uri != null && uri.path == '/') {
            return _fadeRoute(
              getIt<SupabaseClient>().auth.currentUser != null
                  ? const HomeScreen()
                  : const LoginScreen(),
            );
          }

          switch (routeName) {
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

        home: getIt<SupabaseClient>().auth.currentUser != null
            ? const HomeScreen()
            : const LoginScreen(),
      ),
    );
  }
}
