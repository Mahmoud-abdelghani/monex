import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:monex/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:monex/features/auth/presentation/widgets/auth_button.dart';
import 'package:monex/features/auth/presentation/widgets/custom_input_field.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  bool obscure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    FocusScope.of(context).unfocus();
    final isEmailValid = emailKey.currentState?.validate() ?? false;
    final isPasswordValid = passwordKey.currentState?.validate() ?? false;
    if (isEmailValid && isPasswordValid) {
      BlocProvider.of<AuthenticationCubit>(context).loginWithEmailPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInputField(
          fieldKey: emailKey,
          hint: 'Enter your email',
          label: 'Email',
          fieldController: emailController,
          isPassword: false,
          textInputType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty || !value.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        CustomInputField(
          fieldKey: passwordKey,
          hint: 'Enter your password',
          label: 'Password',
          fieldController: passwordController,
          isPassword: true,
          textInputType: TextInputType.visiblePassword,
          isObsecured: obscure,
          onTap: () => setState(() => obscure = !obscure),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF3D5AFE),
            ),
            child: const Text(
              'FORGOT PASSWORD',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            return AuthButton(
              label: 'LOGIN',
              onPressed: _handleLogin,
              isLoading: state is AuthenticationSignInLoading,
            );
          },
        ),
      ],
    );
  }
}
