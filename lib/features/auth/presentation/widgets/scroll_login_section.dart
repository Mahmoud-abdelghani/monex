import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/auth/presentation/screens/register_screen.dart';
import 'package:monex/features/auth/presentation/widgets/google_auth_button.dart';


class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.03),
              child: Text(
                'or',
                style: TextStyle(
                  fontSize: ScreenSize.height * 0.016,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
          ],
        ),
        SizedBox(height: ScreenSize.height * 0.022),
        const GoogleAuthButton(),
        SizedBox(height: ScreenSize.height * 0.028),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(
                fontSize: ScreenSize.height * 0.016,
                color: Colors.grey.shade600,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, RegisterScreen.routeName);
              },
              child: Text(
                'Register here',
                style: TextStyle(
                  fontSize: ScreenSize.height * 0.016,
                  color: const Color(0xFF3D5AFE),
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
