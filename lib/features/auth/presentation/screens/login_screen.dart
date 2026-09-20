import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/auth/presentation/cubit/login_with_email_password_cubit.dart';
import 'package:monex/features/auth/presentation/cubit/sign_in_with_google_cubit.dart';
import 'package:monex/features/auth/presentation/widgets/auth_snackbar.dart';
import 'package:monex/features/auth/presentation/widgets/login_form.dart';
import 'package:monex/features/auth/presentation/widgets/login_header.dart';
import 'package:monex/features/auth/presentation/widgets/scroll_login_section.dart';
import 'package:monex/features/home/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entryController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entryController, curve: Curves.easeOut));

    _entryController.forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return BlocConsumer<SignInWithGoogleCubit, SignInWithGoogleState>(
      listener: (context, state) {
        if (state is SignInWithGoogleSuccess) {
          AuthSnackbar.showSuccess(context, message: 'Welcome back!');
          Future.delayed(const Duration(milliseconds: 400), () {
            if (mounted && context.mounted) {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            }
          });
        } else if (state is SignInWithGoogleFailure) {
          AuthSnackbar.showError(context, message: state.message);
        }
      },
      builder: (context, state) {
        return BlocConsumer<
          LoginWithEmailPasswordCubit,
          LoginWithEmailPasswordState
        >(
          listener: (context, state) {
            if (state is LoginWithEmailPasswordSuccess) {
              AuthSnackbar.showSuccess(context, message: 'Welcome back!');
              Future.delayed(const Duration(milliseconds: 400), () {
                if (mounted && context.mounted) {
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                }
              });
            } else if (state is LoginWithEmailPasswordFailure) {
              AuthSnackbar.showError(context, message: state.message);
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: const [
                            SizedBox(height: 40),
                            LoginHeader(),
                            SizedBox(height: 40),
                            LoginForm(),
                            SizedBox(height: 20),
                            SocialLoginSection(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
