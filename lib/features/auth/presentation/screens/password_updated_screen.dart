import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/auth/presentation/widgets/auth_button.dart';
import 'package:monex/features/home/screens/home_screen.dart';

class PasswordUpdatedScreen extends StatefulWidget {
  const PasswordUpdatedScreen({super.key});

  static const String routeName = '/password-updated';

  @override
  State<PasswordUpdatedScreen> createState() => _PasswordUpdatedScreenState();
}

class _PasswordUpdatedScreenState extends State<PasswordUpdatedScreen>
    with TickerProviderStateMixin {
  // Screen entry: fade + slide
  late final AnimationController _entryController;
  late final Animation<double> _entryFade;
  late final Animation<Offset> _entrySlide;

  // Illustration spring scale
  late final AnimationController _illustrationController;
  late final Animation<double> _illustrationScale;

  // Title stagger
  late final AnimationController _titleController;
  late final Animation<double> _titleFade;

  // Subtitle stagger
  late final AnimationController _subtitleController;
  late final Animation<double> _subtitleFade;

  @override
  void initState() {
    super.initState();

    // ── Entry ──────────────────────────────────────────────────────────────
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _entryFade = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOut,
    );
    _entrySlide = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _entryController, curve: Curves.easeOut));

    // ── Illustration spring ────────────────────────────────────────────────
    _illustrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _illustrationScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _illustrationController,
        curve: Curves.elasticOut,
      ),
    );

    // ── Title ──────────────────────────────────────────────────────────────
    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _titleFade = CurvedAnimation(
      parent: _titleController,
      curve: Curves.easeOut,
    );

    // ── Subtitle ───────────────────────────────────────────────────────────
    _subtitleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _subtitleFade = CurvedAnimation(
      parent: _subtitleController,
      curve: Curves.easeOut,
    );

    // ── Staggered sequence ─────────────────────────────────────────────────
    _entryController.forward();
    Future.delayed(const Duration(milliseconds: 80), () {
      if (mounted) _illustrationController.forward();
    });
    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) _titleController.forward();
    });
    Future.delayed(const Duration(milliseconds: 370), () {
      if (mounted) _subtitleController.forward();
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    _illustrationController.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _entryFade,
          child: SlideTransition(
            position: _entrySlide,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize.width * 0.05,
              ),
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
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Illustration — spring scale entrance
                  Center(
                    child: ScaleTransition(
                      scale: _illustrationScale,
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
                                color: const Color(0xFF3D5AFE).withValues(alpha: 0.07),
                                shape: BoxShape.circle,
                              ),
                            ),

                            // Phone icon
                            Icon(
                              Icons.smartphone_outlined,
                              size: ScreenSize.height * 0.14,
                              color: const Color(0xFF3D5AFE),
                            ),

                            // Password card overlay
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
                                      color: Colors.black.withValues(alpha: 0.08),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
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

                            // Decorative dots
                            Positioned(
                              top: ScreenSize.height * 0.01,
                              left: ScreenSize.width * 0.01,
                              child: _Dot(
                                  color: Colors.orange,
                                  size: ScreenSize.height * 0.012),
                            ),
                            Positioned(
                              top: ScreenSize.height * 0.03,
                              right: ScreenSize.width * 0.02,
                              child: _Dot(
                                  color: Colors.green,
                                  size: ScreenSize.height * 0.01),
                            ),
                            Positioned(
                              bottom: ScreenSize.height * 0.03,
                              left: ScreenSize.width * 0.005,
                              child: _Dot(
                                  color: Colors.redAccent,
                                  size: ScreenSize.height * 0.01),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: ScreenSize.height * 0.05),

                  // Title — staggered fade
                  FadeTransition(
                    opacity: _titleFade,
                    child: Center(
                      child: Text(
                        'Password Updated!',
                        style: TextStyle(
                          fontSize: ScreenSize.height * 0.032,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: ScreenSize.height * 0.012),

                  // Subtitle — staggered fade
                  FadeTransition(
                    opacity: _subtitleFade,
                    child: Center(
                      child: Text(
                        'Your password has been updated\nsuccessfully.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: ScreenSize.height * 0.018,
                          color: Colors.grey.shade500,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Back to home button
                  AuthButton(
                    label: 'BACK TO HOME',
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
