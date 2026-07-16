import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  static const String routeName = '/email-verification';

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends State<EmailVerificationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entryController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: Curves.easeOut,
      ),
    );

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.06,
              ),
              child: Column(
                children: [
                  SizedBox(height: ScreenSize.height * 0.08),

                  /// Illustration
                  Container(
                    width: ScreenSize.height * 0.18,
                    height: ScreenSize.height * 0.18,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3D5AFE)
                          .withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.mark_email_unread_rounded,
                      size: ScreenSize.height * 0.085,
                      color: const Color(0xFF3D5AFE),
                    ),
                  ),

                  SizedBox(height: ScreenSize.height * 0.05),

                  /// Title
                  Text(
                    'Verify your email',
                    style: TextStyle(
                      fontSize: ScreenSize.height * 0.035,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF111827),
                    ),
                  ),

                  SizedBox(height: ScreenSize.height * 0.018),

                  /// Subtitle
                  Text(
                    'We sent you a verification link.\nPlease check your inbox and confirm your account.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenSize.height * 0.018,
                      color: Colors.grey.shade600,
                      height: 1.7,
                    ),
                  ),

                  SizedBox(height: ScreenSize.height * 0.035),

                  /// Info Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(
                      ScreenSize.height * 0.022,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(
                        ScreenSize.height * 0.02,
                      ),
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: const Color(0xFF3D5AFE),
                          size: ScreenSize.height * 0.028,
                        ),
                        SizedBox(width: ScreenSize.width * 0.03),
                        Expanded(
                          child: Text(
                            'After confirming your email, you will be redirected automatically to the app.',
                            style: TextStyle(
                              fontSize: ScreenSize.height * 0.0165,
                              color: Colors.grey.shade700,
                              height: 1.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  /// Footer
                  Text(
                    'Waiting for verification...',
                    style: TextStyle(
                      fontSize: ScreenSize.height * 0.017,
                      color: Colors.grey.shade500,
                    ),
                  ),

                  SizedBox(height: ScreenSize.height * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}