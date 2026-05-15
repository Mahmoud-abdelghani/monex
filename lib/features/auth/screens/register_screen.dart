import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/auth/cubit/authentication_cubit.dart';
import 'package:monex/features/auth/screens/verification_screen.dart';
import 'package:monex/features/auth/widgets/auth_snackbar.dart';
import 'package:monex/features/auth/widgets/login_header.dart';
import 'package:monex/features/auth/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSignUpSuccess) {
          AuthSnackbar.showSuccess(
            context,
            message: 'Sign up successful!',
          );

          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) {
              Navigator.pushNamed(
                context,
                EmailVerificationScreen.routeName,
                arguments: {'email': state.email, 'password': state.password},
              );
            }
          });
        } else if (state is AuthenticationSignUpFailure) {
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
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize.width * 0.05,
                ),
                child: Column(
                  children: [
                    SizedBox(height: ScreenSize.height * 0.05),
                    const LoginHeader(),
                    SizedBox(height: ScreenSize.height * 0.01),
                    Text(
                      "Create your account",
                      style: TextStyle(
                        fontSize: ScreenSize.height * 0.02,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: ScreenSize.height * 0.04),
                    const RegisterForm(),
                    SizedBox(height: ScreenSize.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(fontSize: ScreenSize.height * 0.016),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            "Login here",
                            style: TextStyle(
                              fontSize: ScreenSize.height * 0.016,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenSize.height * 0.03),
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
