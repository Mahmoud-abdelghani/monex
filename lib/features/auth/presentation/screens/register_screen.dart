import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/auth/presentation/cubit/register_cubit.dart';
import 'package:monex/features/auth/presentation/screens/verification_screen.dart';
import 'package:monex/features/auth/presentation/widgets/auth_snackbar.dart';
import 'package:monex/features/auth/presentation/widgets/login_header.dart';
import 'package:monex/features/auth/presentation/widgets/register_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
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

    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          AuthSnackbar.showSuccess(context, message: 'Account created!');
          Future.delayed(const Duration(milliseconds: 400), () {
            if (context.mounted) {
              Navigator.pushNamed(context, EmailVerificationScreen.routeName);
            }
          });
        } else if (state is RegisterFailure) {
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
                      children: [
                        SizedBox(height: ScreenSize.height * 0.05),
                        const LoginHeader(),
                        SizedBox(height: ScreenSize.height * 0.01),
                        Text(
                          'Create your account',
                          style: TextStyle(
                            fontSize: ScreenSize.height * 0.02,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        SizedBox(height: ScreenSize.height * 0.04),
                        const RegisterForm(),
                        SizedBox(height: ScreenSize.height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account? ',
                              style: TextStyle(
                                fontSize: ScreenSize.height * 0.016,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text(
                                'Login here',
                                style: TextStyle(
                                  fontSize: ScreenSize.height * 0.016,
                                  color: const Color(0xFF3D5AFE),
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
            ),
          ),
        );
      },
    );
  }
}
