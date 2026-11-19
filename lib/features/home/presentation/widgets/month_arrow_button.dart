import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';

class MonthArrowButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isEnabled;
  final VoidCallback onTap;

  const MonthArrowButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = ScreenSize.height * 0.05;

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: isEnabled ? onTap : null,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isEnabled ? Colors.grey.shade300 : Colors.grey.shade200,
            ),
          ),
          child: Icon(
            icon,
            size: ScreenSize.height * 0.026,
            color: isEnabled ? HomePalette.textDark : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
