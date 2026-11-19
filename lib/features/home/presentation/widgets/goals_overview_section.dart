import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monex/core/screen_size.dart';
import 'package:monex/features/goals/presentation/cubit/watch_goal_cubit.dart';
import 'package:monex/features/home/presentation/utils/goal_progress.dart';
import 'package:monex/features/home/presentation/widgets/goals_progress_list.dart';
import 'package:monex/features/home/presentation/widgets/home_section_title.dart';
import 'package:monex/features/home/presentation/widgets/section_empty_view.dart';
import 'package:monex/features/home/presentation/widgets/section_error_view.dart';
import 'package:monex/features/home/presentation/widgets/section_loading_view.dart';
import 'package:monex/features/savings/presentation/cubit/watch_savings_cubit.dart';

class GoalsOverviewSection extends StatelessWidget {
  const GoalsOverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeSectionTitle(title: 'Saving Goals'),
        SizedBox(height: ScreenSize.height * 0.012),
        BlocBuilder<WatchGoalCubit, WatchGoalState>(
          builder: (context, goalsState) {
            return BlocBuilder<WatchSavingsCubit, WatchSavingsState>(
              builder: (context, savingsState) {
                if (goalsState is WatchGoalFailure) {
                  return SectionErrorView(message: goalsState.message);
                }
                if (savingsState is WatchSavingsFailure) {
                  return SectionErrorView(message: savingsState.message);
                }
                if (goalsState is WatchGoalSuccess &&
                    savingsState is WatchSavingsSuccess) {
                  if (goalsState.goals.isEmpty) {
                    return const SectionEmptyView(
                      icon: Icons.flag_outlined,
                      title: 'No saving goals yet',
                      message:
                          'Once you create a goal, your savings progress will show up here.',
                    );
                  }

                  return GoalsProgressList(
                    items: GoalProgress.buildAll(
                      goals: goalsState.goals,
                      savings: savingsState.savings,
                    ),
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
