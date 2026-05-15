import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/auth/cubit/authentication_cubit.dart';
import 'package:monex/features/auth/screens/register_screen.dart';
import 'package:monex/features/auth/widgets/modern_loading_button.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Or", style: TextStyle(fontSize: ScreenSize.height * 0.018)),
        SizedBox(height: ScreenSize.height * 0.018),
        BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            final isLoading = state is AuthenticationLoginWithGoogleLoading;
            return GestureDetector(
              onTap: isLoading
                  ? null
                  : () {
                      BlocProvider.of<AuthenticationCubit>(context)
                          .loginWithGoogle();
                    },
              child: Container(
                width: double.infinity,
                height: ScreenSize.height * 0.065,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 1),
                  borderRadius:
                      BorderRadius.circular(ScreenSize.height * 0.018),
                ),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: isLoading
                        ? SizedBox(
                            key: const ValueKey('loading'),
                            width: ScreenSize.height * 0.028,
                            height: ScreenSize.height * 0.028,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF3D5AFE),
                              ),
                            ),
                          )
                        : Row(
                            key: const ValueKey('content'),
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/flat-color-icons_google.png",
                                height: ScreenSize.height * 0.028,
                              ),
                              SizedBox(width: ScreenSize.width * 0.02),
                              Text(
                                "CONTINUE WITH GOOGLE",
                                style: TextStyle(
                                  fontSize: ScreenSize.height * 0.016,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: ScreenSize.height * 0.025),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(fontSize: ScreenSize.height * 0.016),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RegisterScreen.routeName);
              },
              child: Text(
                "Register here",
                style: TextStyle(
                  fontSize: ScreenSize.height * 0.016,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenSize.height * 0.02),
      ],
    );
  }
}
