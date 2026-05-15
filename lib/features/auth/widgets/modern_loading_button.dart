import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';

/// Modern loading button with stable sizing and smooth animations
/// Replaces text content with CircularProgressIndicator during loading
class ModernLoadingButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String label;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final bool isEnabled;

  const ModernLoadingButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    required this.label,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.isEnabled = true,
  });

  @override
  State<ModernLoadingButton> createState() => _ModernLoadingButtonState();
}

class _ModernLoadingButtonState extends State<ModernLoadingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.05,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.96,
    ).animate(CurvedAnimation(parent: _pressController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) => _pressController.forward();
  void _onTapUp(TapUpDetails details) => _pressController.reverse();
  void _onTapCancel() => _pressController.reverse();

  @override
  Widget build(BuildContext context) {
    final isActive = widget.isEnabled && !widget.isLoading;

    return GestureDetector(
      onTapDown: isActive ? _onTapDown : null,
      onTapUp: isActive ? _onTapUp : null,
      onTapCancel: _onTapCancel,
      onTap: isActive ? widget.onPressed : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.width ?? double.infinity,
          height: widget.height ?? ScreenSize.height * 0.068,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                widget.backgroundColor ?? const Color(0xFF3D5AFE),
                widget.backgroundColor ?? const Color(0xFF2979FF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius:
                BorderRadius.circular(ScreenSize.height * 0.018),
            boxShadow: [
              BoxShadow(
                color: (widget.backgroundColor ?? const Color(0xFF3D5AFE))
                    .withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: widget.isLoading
                  ? SizedBox(
                      key: const ValueKey('loading'),
                      width: ScreenSize.height * 0.03,
                      height: ScreenSize.height * 0.03,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      key: const ValueKey('text'),
                      widget.label,
                      style: widget.textStyle ??
                          TextStyle(
                            color: widget.textColor ?? Colors.white,
                            fontSize: ScreenSize.height * 0.02,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.0,
                          ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
