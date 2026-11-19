import 'package:monex/features/goals/domain/entities/goal_entity.dart';
import 'package:monex/features/savings/domain/entities/saving_entity.dart';

/// Presentation model that combines a goal with the total saved for it.
class GoalProgress {
  final GoalEntity goal;
  final double savedAmount;

  /// Fill ratio for the progress bar, always within 0..1.
  final double progress;

  /// Percentage shown to the user, always within 0..100. It only reaches 100
  /// when the goal is actually completed.
  final int percent;

  final bool isCompleted;

  const GoalProgress._({
    required this.goal,
    required this.savedAmount,
    required this.progress,
    required this.percent,
    required this.isCompleted,
  });

  factory GoalProgress.from({
    required GoalEntity goal,
    required double savedAmount,
  }) {
    final target = goal.targetAmount;

    if (target <= 0) {
      return GoalProgress._(
        goal: goal,
        savedAmount: savedAmount,
        progress: 0,
        percent: 0,
        isCompleted: false,
      );
    }

    final isCompleted = savedAmount >= target;
    final rawPercent = (savedAmount * 100 / target).floor();

    return GoalProgress._(
      goal: goal,
      savedAmount: savedAmount,
      progress: isCompleted ? 1 : (savedAmount / target).clamp(0.0, 1.0),
      percent: isCompleted ? 100 : rawPercent.clamp(0, 99).toInt(),
      isCompleted: isCompleted,
    );
  }

  /// Sums savings per goal in a single pass, then lists goals that are still
  /// in progress first and completed goals last.
  static List<GoalProgress> buildAll({
    required List<GoalEntity> goals,
    required List<SavingEntity> savings,
  }) {
    final totals = <String, double>{};
    for (final saving in savings) {
      totals.update(
        saving.goalId,
        (total) => total + saving.amount,
        ifAbsent: () => saving.amount,
      );
    }

    final all = goals
        .map(
          (goal) => GoalProgress.from(
            goal: goal,
            savedAmount: totals[goal.id] ?? 0,
          ),
        )
        .toList();

    return [
      ...all.where((item) => !item.isCompleted),
      ...all.where((item) => item.isCompleted),
    ];
  }

  String get message {
    if (isCompleted) {
      return 'Goal reached. Congratulations on getting it done.';
    }
    return switch (percent) {
      < 20 => 'Every goal starts with a first deposit. Make a start when you are ready.',
      < 40 => 'First milestone reached. You are off to a good start.',
      < 60 => 'Steady progress. Keep up the consistency.',
      < 80 => 'You are getting closer. The finish line is in sight.',
      _ => 'Almost there. One more push to reach your goal.',
    };
  }
}
