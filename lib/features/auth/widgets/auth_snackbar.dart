import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';

/// Reusable snackbar widget for authentication screens
class AuthSnackbar {
  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(milliseconds: 2000),
  }) {
    _show(
      context,
      message: message,
      isSuccess: true,
      duration: duration,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(milliseconds: 2000),
  }) {
    _show(
      context,
      message: message,
      isSuccess: false,
      duration: duration,
    );
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
        duration: const Duration(milliseconds: 200),
        builder: (context, value, child) {
          return Opacity(opacity: value, child: child);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSize.width * 0.04,
            vertical: ScreenSize.height * 0.015,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            borderRadius: BorderRadius.circular(
              ScreenSize.height * 0.014,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSuccess ? Icons.check_circle_outline : Icons.error_outline,
                color: isSuccess ? const Color(0xFF3D5AFE) : Colors.redAccent,
                size: 20,
              ),
              SizedBox(width: ScreenSize.width * 0.02),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenSize.height * 0.016,
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
