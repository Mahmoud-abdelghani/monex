import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/home/presentation/utils/home_palette.dart';

class IncomeExpenseBar extends StatelessWidget {
  final double incomeShare;
  final double expenseShare;

  const IncomeExpenseBar({
    super.key,
    required this.incomeShare,
    required this.expenseShare,
  });

  static int _flexFor(double share) => math.max(1, (share * 1000).round());

  @override
  Widget build(BuildContext context) {
    final height = ScreenSize.height * 0.011;

    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: Container(
        height: height,
        color: HomePalette.track,
        child: Row(
          children: [
            if (incomeShare > 0)
              Expanded(
                flex: _flexFor(incomeShare),
                child: const ColoredBox(color: HomePalette.income),
              ),
            if (incomeShare > 0 && expenseShare > 0)
              SizedBox(width: ScreenSize.width * 0.006),
            if (expenseShare > 0)
              Expanded(
                flex: _flexFor(expenseShare),
                child: const ColoredBox(color: HomePalette.expense),
              ),
          ],
        ),
      ),
    );
  }
}
