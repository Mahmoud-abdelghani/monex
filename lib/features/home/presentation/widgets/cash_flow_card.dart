import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/amount_formatter.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';
import 'package:monex/features/home/presentation/utils/monthly_summary.dart';
import 'package:monex/features/home/presentation/widgets/cash_flow_legend_item.dart';
import 'package:monex/features/home/presentation/widgets/home_surface_card.dart';
import 'package:monex/features/home/presentation/widgets/income_expense_bar.dart';

class CashFlowCard extends StatelessWidget {
  final MonthlySummary summary;

  const CashFlowCard({super.key, required this.summary});

  Color get _netColor {
    if (summary.netCashFlow > 0) return HomePalette.income;
    if (summary.netCashFlow < 0) return HomePalette.expense;
    return HomePalette.textDark;
  }

  @override
  Widget build(BuildContext context) {
    final hasAmounts = summary.incomeTotal + summary.expenseTotal > 0;
    final incomePercent = (summary.incomeShare * 100).round();
    final expensePercent = hasAmounts ? 100 - incomePercent : 0;

    return HomeSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Net cash flow',
                style: TextStyle(
                  fontSize: ScreenSize.height * 0.0165,
                  fontWeight: FontWeight.w600,
                  color: HomePalette.textGrey,
                ),
              ),
              SizedBox(width: ScreenSize.width * 0.03),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      AmountFormatter.signedMoney(summary.netCashFlow),
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: ScreenSize.height * 0.0215,
                        fontWeight: FontWeight.w800,
                        color: _netColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenSize.height * 0.016),
          IncomeExpenseBar(
            incomeShare: summary.incomeShare,
            expenseShare: summary.expenseShare,
          ),
          SizedBox(height: ScreenSize.height * 0.012),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CashFlowLegendItem(
                color: HomePalette.income,
                label: 'Income $incomePercent%',
              ),
              CashFlowLegendItem(
                color: HomePalette.expense,
                label: 'Expenses $expensePercent%',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
