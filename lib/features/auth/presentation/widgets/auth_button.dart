import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';

/// A unified, premium auth button used across all authentication screens.
///
/// Features:
/// - Stable width/height — never resizes during loading.
/// - AnimatedSwitcher: label ↔ CircularProgressIndicator with fade+scale.
/// - Press-scale feedback (1.0 → 0.97).
/// - AnimatedOpacity dims to 0.72 when disabled or loading.
/// - Primary gradient by default; [isOutlined] variant available.
class AuthButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final bool isOutlined;
  final double? width;
  final double? height;
  final Widget? customChild;

  const AuthButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.isOutlined = false,
    this.width,
    this.height,
    this.customChild,
  });

  @override
  State<AuthButton> createState() => _AuthButtonState();
}

class _AuthButtonState extends State<AuthButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressController;
  late final Animation<double> _scaleAnimation;


  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  bool get _isActive => widget.isEnabled && !widget.isLoading;

  void _onTapDown(TapDownDetails _) {
    if (_isActive) _pressController.forward();
  }

  void _onTapUp(TapUpDetails _) => _pressController.reverse();
  void _onTapCancel() => _pressController.reverse();

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = widget.height ?? ScreenSize.height * 0.068;
    final double buttonWidth = widget.width ?? double.infinity;

    return GestureDetector(
      onTapDown: _isActive ? _onTapDown : null,
      onTapUp: _isActive ? _onTapUp : null,
      onTapCancel: _onTapCancel,
      onTap: _isActive ? widget.onPressed : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: _isActive ? 1.0 : 0.72,
          child: widget.isOutlined
              ? _OutlinedContent(
                  width: buttonWidth,
                  height: buttonHeight,
                  isLoading: widget.isLoading,
                  label: widget.label,
                  customChild: widget.customChild,
                )
              : _FilledContent(
                  width: buttonWidth,
                  height: buttonHeight,
                  isLoading: widget.isLoading,
                  label: widget.label,
                ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Filled (gradient) variant
// ---------------------------------------------------------------------------

class _FilledContent extends StatelessWidget {
  final double width;
  final double height;
  final bool isLoading;
  final String label;

  const _FilledContent({
    required this.width,
    required this.height,
    required this.isLoading,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3D5AFE), Color(0xFF2979FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(ScreenSize.height * 0.018),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D5AFE).withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Center(child: _ButtonContent(isLoading: isLoading, label: label)),
    );
  }
}

// ---------------------------------------------------------------------------
// Outlined variant (used by Google button wrapper)
// ---------------------------------------------------------------------------

class _OutlinedContent extends StatelessWidget {
  final double width;
  final double height;
  final bool isLoading;
  final String label;
  final Widget? customChild;

  const _OutlinedContent({
    required this.width,
    required this.height,
    required this.isLoading,
    required this.label,
    this.customChild,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1.2),
        borderRadius: BorderRadius.circular(ScreenSize.height * 0.018),
      ),
      child: Center(
        child: _ButtonContent(
          isLoading: isLoading,
          label: label,
          loadingColor: const Color(0xFF3D5AFE),
          customChild: customChild,
          isOutlined: true,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared content: AnimatedSwitcher label ↔ spinner
// ---------------------------------------------------------------------------

class _ButtonContent extends StatelessWidget {
  final bool isLoading;
  final String label;
  final Color loadingColor;
  final Widget? customChild;
  final bool isOutlined;

  const _ButtonContent({
    required this.isLoading,
    required this.label,
    this.loadingColor = Colors.white,
    this.customChild,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: animation, child: child),
        );
      },
      child: isLoading
          ? SizedBox(
              key: const ValueKey('loading'),
              width: ScreenSize.height * 0.028,
              height: ScreenSize.height * 0.028,
              child: CircularProgressIndicator(
                color: loadingColor,
                strokeWidth: 2.5,
              ),
            )
          : (customChild != null
              ? SizedBox(key: const ValueKey('custom'), child: customChild)
              : Text(
                  key: const ValueKey('text'),
                  label,
                  style: TextStyle(
                    color: isOutlined ? Colors.blueGrey : Colors.white,
                    fontSize: ScreenSize.height * 0.02,
                    fontWeight: FontWeight.w700,
                    letterSpacing: isOutlined ? 1.2 : 2.0,
                  ),
                )),
    );
  }
}
