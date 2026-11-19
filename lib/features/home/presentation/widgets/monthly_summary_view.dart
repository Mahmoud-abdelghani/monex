import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';
import 'package:monex/features/home/presentation/utils/monthly_summary.dart';
import 'package:monex/features/home/presentation/widgets/cash_flow_card.dart';
import 'package:monex/features/home/presentation/widgets/monthly_stat_card.dart';

class MonthlySummaryView extends StatelessWidget {
  final MonthlySummary summary;

  const MonthlySummaryView({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MonthlyStatCard(
                icon: Icons.arrow_downward_rounded,
                title: 'Income',
                amount: summary.incomeTotal,
                count: summary.incomeCount,
                color: HomePalette.income,
              ),
            ),
            SizedBox(width: ScreenSize.width * 0.03),
            Expanded(
              child: MonthlyStatCard(
                icon: Icons.arrow_upward_rounded,
                title: 'Expenses',
                amount: summary.expenseTotal,
                count: summary.expenseCount,
                color: HomePalette.expense,
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenSize.height * 0.014),
        CashFlowCard(summary: summary),
      ],
    );
  }
}
