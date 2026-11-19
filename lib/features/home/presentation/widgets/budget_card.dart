import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/budget/presentation/cubit/watch_budget_cubit.dart';
import 'package:monex/features/home/presentation/utils/amount_formatter.dart';
import 'package:monex/features/home/presentation/widgets/budget_card_frame.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchBudgetCubit, WatchBudgetState>(
      builder: (context, state) {
        if (state is WatchBudgetFailure) {
          return BudgetCardFrame(
            child: Text(
              state.message,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: ScreenSize.height * 0.016,
                color: Colors.white,
              ),
            ),
          );
        }

        if (state is WatchBudgetSuccess) {
          final budget = state.budget;

          if (budget == null) {
            return BudgetCardFrame(
              child: Text(
                'No budget available yet',
                style: TextStyle(
                  fontSize: ScreenSize.height * 0.022,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            );
          }

          return BudgetCardFrame(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text.rich(
                TextSpan(
                  text: AmountFormatter.number(budget.balance),
                  style: TextStyle(
                    fontSize: ScreenSize.height * 0.05,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: ' ${AmountFormatter.currency}',
                      style: TextStyle(
                        fontSize: ScreenSize.height * 0.02,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
                maxLines: 1,
              ),
            ),
          );
        }

        return BudgetCardFrame(
          child: SizedBox(
            width: ScreenSize.height * 0.03,
            height: ScreenSize.height * 0.03,
            child: const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.5,
            ),
          ),
        );
      },
    );
  }
}
