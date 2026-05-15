import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/core/services/supabase_service.dart';
import 'package:monex/features/auth/cubit/authentication_cubit.dart';
import 'package:monex/features/auth/widgets/auth_snackbar.dart';
import 'package:monex/features/auth/widgets/login_button.dart';
import 'package:monex/features/home/screens/home_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static const String routeName = '/email-verification';

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen>
    with SingleTickerProviderStateMixin {
  bool isConfirmed = false;

  void _showNotVerifiedSnackbar() {
    AuthSnackbar.showError(
      context,
      message: 'Please verify your email first',
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is VerificationSuccess) {
          log(SupabaseService.supabase.auth.currentUser!.toString());
          AuthSnackbar.showSuccess(
            context,
            message: 'Email verified successfully',
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            }
          });
        } else if (state is VerificationFailure) {
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
                  const Spacer(),
                  Center(
                    child: SizedBox(
                      width: ScreenSize.height * 0.26,
                      height: ScreenSize.height * 0.26,
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: ScreenSize.height * 0.22,
                            height: ScreenSize.height * 0.22,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Icon(
                            Icons.mark_email_unread_outlined,
                            size: ScreenSize.height * 0.1,
                            color: const Color(0xFF3D5AFE),
                          ),
                          Positioned(
                            top: ScreenSize.height * 0.018,
                            right: ScreenSize.width * 0.02,
                            child: Container(
                              width: ScreenSize.height * 0.04,
                              height: ScreenSize.height * 0.04,
                              decoration: const BoxDecoration(
                                color: Color(0xFF3D5AFE),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: ScreenSize.height * 0.024,
                              ),
                            ),
                          ),
                          Positioned(
                            top: ScreenSize.height * 0.01,
                            left: ScreenSize.width * 0.01,
                            child: _Dot(
                              color: Colors.orange,
                              size: ScreenSize.height * 0.012,
                            ),
                          ),
                          Positioned(
                            bottom: ScreenSize.height * 0.03,
                            right: ScreenSize.width * 0.01,
                            child: _Dot(
                              color: Colors.green,
                              size: ScreenSize.height * 0.01,
                            ),
                          ),
                          Positioned(
                            bottom: ScreenSize.height * 0.02,
                            left: ScreenSize.width * 0.005,
                            child: _Dot(
                              color: Colors.red,
                              size: ScreenSize.height * 0.01,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenSize.height * 0.04),
                  Center(
                    child: Text(
                      'Verify your email',
                      style: TextStyle(
                        fontSize: ScreenSize.height * 0.032,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenSize.height * 0.012),
                  Center(
                    child: Text(
                      'We\'ve sent a verification link to your\nemail address. Please check your inbox.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ScreenSize.height * 0.018,
                        color: Colors.grey,
                        height: 1.6,
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenSize.height * 0.04),
                  GestureDetector(
                    onTap: () => setState(() => isConfirmed = !isConfirmed),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize.width * 0.04,
                        vertical: ScreenSize.height * 0.018,
                      ),
                      decoration: BoxDecoration(
                        color: isConfirmed
                            ? const Color(0xFF3D5AFE).withOpacity(0.08)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(
                          ScreenSize.height * 0.016,
                        ),
                        border: Border.all(
                          color: isConfirmed
                              ? const Color(0xFF3D5AFE)
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: ScreenSize.height * 0.03,
                            height: ScreenSize.height * 0.03,
                            decoration: BoxDecoration(
                              color: isConfirmed
                                  ? const Color(0xFF3D5AFE)
                                  : Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isConfirmed
                                    ? const Color(0xFF3D5AFE)
                                    : Colors.grey.shade400,
                                width: 1.5,
                              ),
                            ),
                            child: isConfirmed
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: ScreenSize.height * 0.018,
                                  )
                                : null,
                          ),
                          SizedBox(width: ScreenSize.width * 0.03),
                          Text(
                            'I have confirmed my email',
                            style: TextStyle(
                              fontSize: ScreenSize.height * 0.018,
                              fontWeight: FontWeight.w500,
                              color: isConfirmed
                                  ? const Color(0xFF3D5AFE)
                                  : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenSize.height * 0.03),
                  BlocBuilder<AuthenticationCubit, AuthenticationState>(
                    builder: (context, state) {
                      return LoginButton(
                        label: 'CONTINUE',
                        isLoading: state is VerificationLoading,
                        onPressed: () {
                          if (!isConfirmed) {
                            _showNotVerifiedSnackbar();
                            return;
                          }
                          BlocProvider.of<AuthenticationCubit>(context)
                              .verifyEmail(
                            email: args['email'],
                            password: args['password'],
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: ScreenSize.height * 0.02),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  final double size;

  const _Dot({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
