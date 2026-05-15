import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/auth/cubit/authentication_cubit.dart';
import 'package:monex/features/auth/widgets/auth_snackbar.dart';
import 'package:monex/features/auth/widgets/login_form.dart';
import 'package:monex/features/auth/widgets/login_header.dart';
import 'package:monex/features/auth/widgets/scroll_login_section.dart';
import 'package:monex/features/home/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoginWithGoogleSuccess ||
            state is AuthenticationSignInSuccess) {
          AuthSnackbar.showSuccess(
            context,
            message: 'Login successful',
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            }
          });
        } else if (state is AuthenticationLoginWithGoogleFailure) {
          AuthSnackbar.showError(
            context,
            message: state.message,
          );
        } else if (state is AuthenticationSignInFailure) {
          AuthSnackbar.showError(
            context,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
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
        );
      },
    );
  }
}
