import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';

class MonthPickerCell extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  const MonthPickerCell({
    super.key,
    required this.label,
    required this.isSelected,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor;
    if (isSelected) {
      textColor = Colors.white;
    } else if (isEnabled) {
      textColor = HomePalette.textDark;
    } else {
      textColor = Colors.grey.shade400;
    }

    return Semantics(
      button: true,
      enabled: isEnabled,
      selected: isSelected,
      label: label,
      child: GestureDetector(
        onTap: isEnabled ? onTap : null,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? HomePalette.primary
                : (isEnabled ? HomePalette.background : Colors.transparent),
            borderRadius: BorderRadius.circular(ScreenSize.height * 0.015),
            border: (isSelected || !isEnabled)
                ? null
                : Border.all(color: HomePalette.track),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: ScreenSize.height * 0.017,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
