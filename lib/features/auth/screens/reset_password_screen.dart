import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/auth/cubit/authentication_cubit.dart';
import 'package:monex/features/auth/screens/password_updated_screen.dart';
import 'package:monex/features/auth/widgets/auth_snackbar.dart';
import 'package:monex/features/auth/widgets/custom_input_field.dart';
import 'package:monex/features/auth/widgets/login_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static const String routeName = '/reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> confirmPasswordKey = GlobalKey<FormState>();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirm = true;

  void _handleReset() {
    final isPasswordValid = passwordKey.currentState?.validate() ?? false;
    final isConfirmValid = confirmPasswordKey.currentState?.validate() ?? false;

    if (isPasswordValid && isConfirmValid) {
      BlocProvider.of<AuthenticationCubit>(context)
          .updatePassword(newPassword: passwordController.text);
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is UpdatePasswordSuccess) {
          AuthSnackbar.showSuccess(
            context,
            message: 'Password updated successfully',
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              Navigator.pushReplacementNamed(
                context,
                PasswordUpdatedScreen.routeName,
              );
            }
          });
        } else if (state is UpdatePasswordFailure) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ScreenSize.height * 0.02),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: ScreenSize.height * 0.05,
                        height: ScreenSize.height * 0.05,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Icon(
                          Icons.chevron_left,
                          size: ScreenSize.height * 0.03,
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenSize.height * 0.05),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: ScreenSize.height * 0.18,
                            height: ScreenSize.height * 0.18,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Icon(
                            Icons.lock_reset_rounded,
                            size: ScreenSize.height * 0.08,
                            color: const Color(0xFF3D5AFE),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenSize.height * 0.04),
                    Center(
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: ScreenSize.height * 0.03,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenSize.height * 0.012),
                    Center(
                      child: Text(
                        'Your new password must be different\nfrom your previous password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenSize.height * 0.018,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenSize.height * 0.045),
                    CustomInputField(
                      fieldKey: passwordKey,
                      hint: 'Enter new password',
                      label: 'New Password',
                      fieldController: passwordController,
                      isPassword: true,
                      textInputType: TextInputType.visiblePassword,
                      isObsecured: obscurePassword,
                      onTap: () =>
                          setState(() => obscurePassword = !obscurePassword),
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
                    SizedBox(height: ScreenSize.height * 0.02),
                    CustomInputField(
                      fieldKey: confirmPasswordKey,
                      hint: 'Re-enter new password',
                      label: 'Confirm Password',
                      fieldController: confirmPasswordController,
                      isPassword: true,
                      textInputType: TextInputType.visiblePassword,
                      isObsecured: obscureConfirm,
                      onTap: () =>
                          setState(() => obscureConfirm = !obscureConfirm),
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
                    SizedBox(height: ScreenSize.height * 0.035),
                    BlocBuilder<AuthenticationCubit, AuthenticationState>(
                      builder: (context, state) {
                        return LoginButton(
                          label: 'RESET PASSWORD',
                          onPressed: _handleReset,
                          isLoading: state is UpdatePasswordLoading,
                        );
                      },
                    ),
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
