import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/auth/widgets/login_button.dart';
import 'package:monex/features/auth/screens/login_screen.dart';
import 'package:monex/features/home/screens/home_screen.dart';

class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({super.key});

  static const String routeName = '/password-updated';

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ScreenSize.height * 0.02),

              // Back button
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

              // Spacer pushes content to vertical center
              const Spacer(),

              // Illustration — phone with check badge + masked password
              Center(
                child: SizedBox(
                  width: ScreenSize.height * 0.26,
                  height: ScreenSize.height * 0.26,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // Background circle
                      Container(
                        width: ScreenSize.height * 0.22,
                        height: ScreenSize.height * 0.22,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                      ),

                      // Phone outline icon
                      Icon(
                        Icons.smartphone_outlined,
                        size: ScreenSize.height * 0.14,
                        color: const Color(0xFF3D5AFE),
                      ),

                      // Password card overlay (bottom-right)
                      Positioned(
                        bottom: ScreenSize.height * 0.01,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenSize.width * 0.03,
                            vertical: ScreenSize.height * 0.008,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              ScreenSize.height * 0.012,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Blue check circle
                              Container(
                                width: ScreenSize.height * 0.032,
                                height: ScreenSize.height * 0.032,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF3D5AFE),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: ScreenSize.height * 0.02,
                                ),
                              ),
                              SizedBox(width: ScreenSize.width * 0.02),
                              // Dots (masked password)
                              Text(
                                '● ● ● ●',
                                style: TextStyle(
                                  fontSize: ScreenSize.height * 0.016,
                                  color: Colors.black87,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Decorative colored dots
                      Positioned(
                        top: ScreenSize.height * 0.01,
                        left: ScreenSize.width * 0.01,
                        child: _Dot(
                          color: Colors.orange,
                          size: ScreenSize.height * 0.012,
                        ),
                      ),
                      Positioned(
                        top: ScreenSize.height * 0.03,
                        right: ScreenSize.width * 0.02,
                        child: _Dot(
                          color: Colors.green,
                          size: ScreenSize.height * 0.01,
                        ),
                      ),
                      Positioned(
                        bottom: ScreenSize.height * 0.03,
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

              SizedBox(height: ScreenSize.height * 0.05),

              // Title
              Center(
                child: Text(
                  'Password updated!',
                  style: TextStyle(
                    fontSize: ScreenSize.height * 0.032,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
              ),

              SizedBox(height: ScreenSize.height * 0.012),

              // Subtitle
              Center(
                child: Text(
                  'Your password has been setup\nsuccessfully',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ScreenSize.height * 0.018,
                    color: Colors.grey,
                    height: 1.6,
                  ),
                ),
              ),

              const Spacer(),

              // Back to login button
              LoginButton(
                label: 'BACK TO LOGIN',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomeScreen.routeName,
                    (route) => false,
                  );
                },
              ),

              SizedBox(height: ScreenSize.height * 0.03),
            ],
          ),
        ),
      ),
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
