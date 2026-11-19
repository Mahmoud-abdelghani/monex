import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monex/core/screen_size.dart';

/// A tappable row that shows a label, supporting hint, and a selected
/// date/time value. Calls [onTap] so the parent can open whichever
/// picker it needs (date-only or date+time).
class DateTimePickerRow extends StatelessWidget {
  final String label;
  final String hint;
  final DateTime? value;

  /// Whether to show time in addition to date.
  final bool showTime;

  final VoidCallback onTap;

  const DateTimePickerRow({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.onTap,
    this.showTime = false,
  });

  String get _formatted {
    if (value == null) return hint;
    final datePart = DateFormat('d MMM yyyy').format(value!);
    if (!showTime) return datePart;
    final timePart = DateFormat('h:mm a').format(value!);
    return '$datePart  •  $timePart';
  }

  bool get _hasValue => value != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: ScreenSize.width * 0.04,
          vertical: ScreenSize.height * 0.016,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(ScreenSize.height * 0.015),
          border: Border.all(
            color: _hasValue
                ? const Color(0xFF3D5AFE)
                : Colors.grey.shade400,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: label + value
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: ScreenSize.height * 0.014,
                      color: _hasValue
                          ? const Color(0xFF3D5AFE)
                          : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: ScreenSize.height * 0.004),
                  Text(
                    _formatted,
                    style: TextStyle(
                      fontSize: ScreenSize.height * 0.016,
                      color: _hasValue
                          ? const Color(0xFF1A1A2E)
                          : Colors.grey.shade400,
                      fontWeight:
                          _hasValue ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              showTime
                  ? Icons.access_time_outlined
                  : Icons.calendar_today_outlined,
              size: ScreenSize.height * 0.022,
              color: _hasValue
                  ? const Color(0xFF3D5AFE)
                  : Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}