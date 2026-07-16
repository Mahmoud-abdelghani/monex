import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:monex/features/auth/presentation/screens/password_updated_screen.dart';
import 'package:monex/features/auth/presentation/widgets/auth_button.dart';
import 'package:monex/features/auth/presentation/widgets/auth_snackbar.dart';
import 'package:monex/features/auth/presentation/widgets/custom_input_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  static const String routeName = '/reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> confirmPasswordKey = GlobalKey<FormState>();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirm = true;

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
    passwordController.dispose();
    confirmPasswordController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  void _handleReset() {
    FocusScope.of(context).unfocus();
    final isPasswordValid = passwordKey.currentState?.validate() ?? false;
    final isConfirmValid = confirmPasswordKey.currentState?.validate() ?? false;

    if (isPasswordValid && isConfirmValid) {
      BlocProvider.of<AuthenticationCubit>(
        context,
      ).updatePassword(newPassword: passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is UpdatePasswordSuccess) {
          AuthSnackbar.showSuccess(
            context,
            message: 'Password updated successfully!',
          );
          Future.delayed(const Duration(milliseconds: 400), () {
            if (mounted && context.mounted) {
              Navigator.pushReplacementNamed(
                context,
                PasswordUpdatedScreen.routeName,
              );
            }
          });
        } else if (state is UpdatePasswordFailure) {
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
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize.width * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ScreenSize.height * 0.02),
                        _BackButton(),
                        SizedBox(height: ScreenSize.height * 0.05),
                        Center(
                          child: Container(
                            width: ScreenSize.height * 0.16,
                            height: ScreenSize.height * 0.16,
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFF3D5AFE,
                              ).withValues(alpha: 0.07),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.lock_reset_rounded,
                                size: ScreenSize.height * 0.07,
                                color: const Color(0xFF3D5AFE),
                              ),
                            ),
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
                              color: Colors.grey.shade500,
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
                          onTap: () => setState(
                            () => obscurePassword = !obscurePassword,
                          ),
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
                            return AuthButton(
                              label: 'RESET PASSWORD',
                              onPressed: _handleReset,
                              isLoading: state is UpdatePasswordLoading,
                            );
                          },
                        ),
                        SizedBox(height: ScreenSize.height * 0.04),
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
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
          color: const Color(0xFF1A1A2E),
        ),
      ),
    );
  }
}
