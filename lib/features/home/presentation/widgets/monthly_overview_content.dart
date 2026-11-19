import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/expense/domain/entities/expense_entity.dart';
import 'package:monex/features/home/presentation/utils/month_range.dart';
import 'package:monex/features/home/presentation/utils/monthly_summary.dart';
import 'package:monex/features/home/presentation/widgets/month_selector.dart';
import 'package:monex/features/home/presentation/widgets/monthly_summary_view.dart';
import 'package:monex/features/home/presentation/widgets/section_empty_view.dart';
import 'package:monex/features/income/domain/entities/income_entity.dart';

/// Renders the month selector and the summary for the selected month.
///
/// Only the [ValueListenableBuilder] subtree rebuilds when the user changes
/// the month, so the rest of the Home screen is untouched.
class MonthlyOverviewContent extends StatelessWidget {
  final List<IncomeEntity> incomes;
  final List<ExpenseEntity> expenses;
  final ValueNotifier<DateTime> selectedMonth;

  const MonthlyOverviewContent({
    super.key,
    required this.incomes,
    required this.expenses,
    required this.selectedMonth,
  });

  @override
  Widget build(BuildContext context) {
    final range = MonthRange.fromTransactions(
      incomes: incomes,
      expenses: expenses,
      now: DateTime.now(),
    );

    if (!range.hasTransactions) {
      return const SectionEmptyView(
        icon: Icons.receipt_long_rounded,
        title: 'No transactions yet',
        message:
            'Your monthly income and expenses will appear here once you record them.',
      );
    }

    return ValueListenableBuilder<DateTime>(
      valueListenable: selectedMonth,
      builder: (context, value, _) {
        final month = range.clamp(value);
        final summary = MonthlySummary.forMonth(
          month: month,
          incomes: incomes,
          expenses: expenses,
        );

        return Column(
          children: [
            MonthSelector(
              selectedMonth: month,
              range: range,
              onChanged: (newMonth) => selectedMonth.value = newMonth,
            ),
            SizedBox(height: ScreenSize.height * 0.014),
            if (summary.isEmpty)
              SectionEmptyView(
                icon: Icons.event_busy_rounded,
                title:
                    'Nothing recorded in ${DateFormat('MMMM yyyy', 'en_US').format(month)}',
                message: 'No income or expenses were added during this month.',
              )
            else
              MonthlySummaryView(summary: summary),
          ],
        );
      },
    );
  }
}
