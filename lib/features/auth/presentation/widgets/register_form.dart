import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:monex/features/auth/presentation/widgets/auth_button.dart';
import 'package:monex/features/auth/presentation/widgets/custom_input_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> usernameKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();

  final GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> confirmPasswordKey = GlobalKey<FormState>();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirm = true;

  void _handleRegister() {
    FocusScope.of(context).unfocus();
    final isUsernameValid = usernameKey.currentState?.validate() ?? false;
    final isEmailValid = emailKey.currentState?.validate() ?? false;
    final isPasswordValid = passwordKey.currentState?.validate() ?? false;
    final isConfirmValid = confirmPasswordKey.currentState?.validate() ?? false;

    if (isUsernameValid && isEmailValid && isPasswordValid && isConfirmValid) {
      BlocProvider.of<AuthenticationCubit>(context).signUp(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
      );
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomInputField(
          fieldKey: usernameKey,
          hint: 'Enter your username',
          label: 'Username',
          fieldController: usernameController,
          isPassword: false,
          textInputType: TextInputType.text,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a username';
            }
            if (value.trim().length < 3) {
              return 'Username must be at least 3 characters';
            }
            return null;
          },
        ),
        SizedBox(height: ScreenSize.height * 0.018),
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
        SizedBox(height: ScreenSize.height * 0.018),
        CustomInputField(
          fieldKey: passwordKey,
          hint: 'Enter your password',
          label: 'Password',
          fieldController: passwordController,
          isPassword: true,
          textInputType: TextInputType.visiblePassword,
          isObsecured: obscurePassword,
          onTap: () => setState(() => obscurePassword = !obscurePassword),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
        SizedBox(height: ScreenSize.height * 0.018),
        CustomInputField(
          fieldKey: confirmPasswordKey,
          hint: 'Re-enter your password',
          label: 'Confirm Password',
          fieldController: confirmPasswordController,
          isPassword: true,
          textInputType: TextInputType.visiblePassword,
          isObsecured: obscureConfirm,
          onTap: () => setState(() => obscureConfirm = !obscureConfirm),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
        SizedBox(height: ScreenSize.height * 0.03),
        BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            return AuthButton(
              label: 'REGISTER',
              onPressed: _handleRegister,
              isLoading: state is AuthenticationSignUpLoading,
            );
          },
        ),
      ],
    );
  }
}
