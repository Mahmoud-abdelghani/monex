import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:monex/features/auth/presentation/widgets/auth_button.dart';
/// Google sign-in button.
///
/// Reads [AuthenticationLoginWithGoogleLoading] from the Bloc and shows
/// a [CircularProgressIndicator] inside the button during loading.
/// Stable sizing — never resizes on state change.
class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final isLoading = state is AuthenticationLoginWithGoogleLoading;
        return AuthButton(
          label: 'CONTINUE WITH GOOGLE',
          isLoading: isLoading,
          isOutlined: true,
          onPressed: () {
            BlocProvider.of<AuthenticationCubit>(context).loginWithGoogle();
          },
          customChild: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/flat-color-icons_google.png',
                height: ScreenSize.height * 0.028,
              ),
              SizedBox(width: ScreenSize.width * 0.025),
              Text(
                'CONTINUE WITH GOOGLE',
                style: TextStyle(
                  fontSize: ScreenSize.height * 0.016,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
