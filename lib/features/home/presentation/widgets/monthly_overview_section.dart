import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/expense/presentation/cubit/watch_expenses_cubit.dart';
import 'package:monex/features/home/presentation/utils/month_range.dart';
import 'package:monex/features/home/presentation/widgets/home_section_title.dart';
import 'package:monex/features/home/presentation/widgets/monthly_overview_content.dart';
import 'package:monex/features/home/presentation/widgets/section_error_view.dart';
import 'package:monex/features/home/presentation/widgets/section_loading_view.dart';
import 'package:monex/features/income/presentation/cubit/watch_incomes_cubit.dart';

class MonthlyOverviewSection extends StatefulWidget {
  const MonthlyOverviewSection({super.key});

  @override
  State<MonthlyOverviewSection> createState() => _MonthlyOverviewSectionState();
}

class _MonthlyOverviewSectionState extends State<MonthlyOverviewSection> {
  final ValueNotifier<DateTime> _selectedMonth = ValueNotifier<DateTime>(
    MonthRange.firstDayOfMonth(DateTime.now()),
  );

  @override
  void dispose() {
    _selectedMonth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeSectionTitle(title: 'Monthly Overview'),
        SizedBox(height: ScreenSize.height * 0.012),
        BlocBuilder<WatchIncomesCubit, WatchIncomesState>(
          builder: (context, incomesState) {
            return BlocBuilder<WatchExpensesCubit, WatchExpensesState>(
              builder: (context, expensesState) {
                if (incomesState is WatchIncomesFailure) {
                  return SectionErrorView(message: incomesState.message);
                }
                if (expensesState is WatchExpensesFailure) {
                  return SectionErrorView(message: expensesState.message);
                }
                if (incomesState is WatchIncomesSuccess &&
                    expensesState is WatchExpensesSuccess) {
                  return MonthlyOverviewContent(
                    incomes: incomesState.incomes,
                    expenses: expensesState.expenses,
                    selectedMonth: _selectedMonth,
                  );
                }
                return const SectionLoadingView();
              },
            );
          },
        ),
      ],
    );
  }
}
