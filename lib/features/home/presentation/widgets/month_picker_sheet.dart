import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';
import 'package:monex/features/home/presentation/utils/month_range.dart';
import 'package:monex/features/home/presentation/widgets/month_arrow_button.dart';
import 'package:monex/features/home/presentation/widgets/month_picker_cell.dart';

class MonthPickerSheet extends StatefulWidget {
  final DateTime selectedMonth;
  final MonthRange range;

  const MonthPickerSheet({
    super.key,
    required this.selectedMonth,
    required this.range,
  });

  static Future<DateTime?> show(
    BuildContext context, {
    required DateTime selectedMonth,
    required MonthRange range,
  }) {
    return showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => MonthPickerSheet(
        selectedMonth: selectedMonth,
        range: range,
      ),
    );
  }

  @override
  State<MonthPickerSheet> createState() => _MonthPickerSheetState();
}

class _MonthPickerSheetState extends State<MonthPickerSheet> {
  static const List<String> _monthLabels = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  late int _year = widget.selectedMonth.year;

  bool _isSelected(DateTime month) =>
      month.year == widget.selectedMonth.year &&
      month.month == widget.selectedMonth.month;

  @override
  Widget build(BuildContext context) {
    final range = widget.range;

    return Container(
      padding: EdgeInsets.fromLTRB(
        ScreenSize.width * 0.05,
        ScreenSize.height * 0.015,
        ScreenSize.width * 0.05,
        ScreenSize.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ScreenSize.height * 0.028),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: ScreenSize.width * 0.1,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.02),
            Text(
              'Select month',
              style: TextStyle(
                fontSize: ScreenSize.height * 0.021,
                fontWeight: FontWeight.w700,
                color: HomePalette.textDark,
              ),
            ),
            SizedBox(height: ScreenSize.height * 0.02),
            Row(
              children: [
                MonthArrowButton(
                  icon: Icons.chevron_left_rounded,
                  label: 'Previous year',
                  isEnabled: _year > range.earliest.year,
                  onTap: () => setState(() => _year--),
                ),
                Expanded(
                  child: Text(
                    '$_year',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: ScreenSize.height * 0.02,
                      fontWeight: FontWeight.w700,
                      color: HomePalette.textDark,
                    ),
                  ),
                ),
                MonthArrowButton(
                  icon: Icons.chevron_right_rounded,
                  label: 'Next year',
                  isEnabled: _year < range.latest.year,
                  onTap: () => setState(() => _year++),
                ),
              ],
            ),
            SizedBox(height: ScreenSize.height * 0.02),
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _monthLabels.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: ScreenSize.height * 0.012,
                crossAxisSpacing: ScreenSize.width * 0.03,
                mainAxisExtent: ScreenSize.height * 0.06,
              ),
              itemBuilder: (context, index) {
                final month = DateTime(_year, index + 1);
                return MonthPickerCell(
                  label: _monthLabels[index],
                  isSelected: _isSelected(month),
                  isEnabled: range.contains(month),
                  onTap: () => Navigator.of(context).pop(month),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
