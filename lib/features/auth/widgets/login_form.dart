import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/features/auth/cubit/authentication_cubit.dart';
import 'package:monex/features/auth/screens/forgot_password_screen.dart';
import 'package:monex/features/auth/widgets/custom_input_field.dart';
import 'package:monex/features/auth/widgets/login_button.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  bool obscure = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
              return 'Please enter some text';
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
              return 'Please enter some text';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, ForgotPasswordScreen.routeName);
            },
            child: const Text("FORGOT PASSWORD"),
          ),
        ),
        const SizedBox(height: 10),
        BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            return LoginButton(
              onPressed: () {
                if (emailKey.currentState?.validate() ?? false) {
                  if (passwordKey.currentState?.validate() ?? false) {
                    BlocProvider.of<AuthenticationCubit>(context)
                        .loginWithEmailPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  }
                }
              },
              isLoading: state is AuthenticationSignInLoading,
            );
          },
        ),
      ],
    );
  }
}
