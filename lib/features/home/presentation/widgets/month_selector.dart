import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';
import 'package:monex/features/home/presentation/utils/month_range.dart';
import 'package:monex/features/home/presentation/widgets/home_surface_card.dart';
import 'package:monex/features/home/presentation/widgets/month_arrow_button.dart';
import 'package:monex/features/home/presentation/widgets/month_picker_sheet.dart';

class MonthSelector extends StatelessWidget {
  final DateTime selectedMonth;
  final MonthRange range;
  final ValueChanged<DateTime> onChanged;

  const MonthSelector({
    super.key,
    required this.selectedMonth,
    required this.range,
    required this.onChanged,
  });

  Future<void> _openPicker(BuildContext context) async {
    final picked = await MonthPickerSheet.show(
      context,
      selectedMonth: selectedMonth,
      range: range,
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final canPick = range.monthCount > 1;

    return HomeSurfaceCard(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.03,
        vertical: ScreenSize.height * 0.01,
      ),
      child: Row(
        children: [
          MonthArrowButton(
            icon: Icons.chevron_left_rounded,
            label: 'Previous month',
            isEnabled: range.canGoPrevious(selectedMonth),
            onTap: () => onChanged(MonthRange.shift(selectedMonth, -1)),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: canPick ? () => _openPicker(context) : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      DateFormat('MMM yyyy', 'en_US').format(selectedMonth),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: ScreenSize.height * 0.0195,
                        fontWeight: FontWeight.w700,
                        color: HomePalette.textDark,
                      ),
                    ),
                  ),
                  if (canPick)
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: ScreenSize.height * 0.028,
                      color: HomePalette.primary,
                    ),
                ],
              ),
            ),
          ),
          MonthArrowButton(
            icon: Icons.chevron_right_rounded,
            label: 'Next month',
            isEnabled: range.canGoNext(selectedMonth),
            onTap: () => onChanged(MonthRange.shift(selectedMonth, 1)),
          ),
        ],
      ),
    );
  }
}
