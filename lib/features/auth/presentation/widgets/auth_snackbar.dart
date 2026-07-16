import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';

/// Reusable snackbar widget for authentication screens.
///
/// Shows a premium dark pill notification with:
/// - Smooth fade-in animation
/// - Subtle slide-up translation (8px → 0)
class AuthSnackbar {
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(milliseconds: 2500),
  }) {
    _show(context, message: message, isSuccess: true, duration: duration);
  }

  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(milliseconds: 2500),
  }) {
    _show(context, message: message, isSuccess: false, duration: duration);
  }

  static void _show(
    BuildContext context, {
    required String message,
    required bool isSuccess,
    required Duration duration,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      content: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 8 * (1 - value)),
              child: child,
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.width * 0.04,
            vertical: ScreenSize.height * 0.016,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.014),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isSuccess
                      ? const Color(0xFF3D5AFE).withValues(alpha: 0.15)
                      : Colors.redAccent.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSuccess
                      ? Icons.check_circle_outline_rounded
                      : Icons.error_outline_rounded,
                  color:
                      isSuccess ? const Color(0xFF3D5AFE) : Colors.redAccent,
                  size: 18,
                ),
              ),
              SizedBox(width: ScreenSize.width * 0.025),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenSize.height * 0.016,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
