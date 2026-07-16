import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:monex/features/auth/presentation/widgets/auth_button.dart';
import 'package:monex/features/auth/presentation/widgets/auth_snackbar.dart';
import 'package:monex/features/auth/presentation/widgets/custom_input_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const String routeName = '/forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

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
    emailController.dispose();
    _entryController.dispose();
    super.dispose();
  }

  void _handleSend() {
    FocusScope.of(context).unfocus();
    if (emailKey.currentState?.validate() ?? false) {
      BlocProvider.of<AuthenticationCubit>(
        context,
      ).sendEmailForPasswordReset(email: emailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          AuthSnackbar.showSuccess(
            context,
            message: 'Reset link sent! Check your inbox.',
          );
        } else if (state is ForgetPasswordFailure) {
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
                                Icons.lock_outline_rounded,
                                size: ScreenSize.height * 0.07,
                                color: const Color(0xFF3D5AFE),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenSize.height * 0.04),
                        Center(
                          child: Text(
                            'Forgot Password?',
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
                            'Enter your email address and we\'ll\nsend you a reset link',
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
                          fieldKey: emailKey,
                          hint: 'Enter your email',
                          label: 'Email',
                          fieldController: emailController,
                          isPassword: false,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: ScreenSize.height * 0.035),
                        BlocBuilder<AuthenticationCubit, AuthenticationState>(
                          builder: (context, state) {
                            return AuthButton(
                              label: 'SEND RESET LINK',
                              onPressed: _handleSend,
                              isLoading: state is ForgetPasswordLoading,
                            );
                          },
                        ),
                        SizedBox(height: ScreenSize.height * 0.03),
                        Center(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: RichText(
                              text: TextSpan(
                                text: 'Remember your password? ',
                                style: TextStyle(
                                  fontSize: ScreenSize.height * 0.016,
                                  color: Colors.grey.shade500,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Login',
                                    style: TextStyle(
                                      color: const Color(0xFF3D5AFE),
                                      fontWeight: FontWeight.w600,
                                      fontSize: ScreenSize.height * 0.016,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
