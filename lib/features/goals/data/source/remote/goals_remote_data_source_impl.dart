import 'package:monex/features/goals/data/models/goal_model.dart';
import 'package:monex/features/goals/data/source/remote/goals_remote_data_source.dart';
import 'package:monex/features/goals/domain/entities/goal_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoalsRemoteDataSourceImpl implements GoalsRemoteDataSource {
  final SupabaseClient supabaseClient;

  GoalsRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<void> completeGoal(String goalId) async {
    return await supabaseClient
        .from('goals')
        .update({'status': GoalStatus.completed.index})
        .eq('id', goalId);
  }

  @override
  Future<void> deleteGoal(String goalId) async {
    return await supabaseClient.from('goals').delete().eq('id', goalId);
  }

  @override
  Future<GoalModel?> getGoalById(String goalId) async {
    final response = await supabaseClient
        .from('goals')
        .select()
        .eq('id', goalId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return GoalModel.fromJson(response);
  }

  @override
  Future<List<GoalModel>> getGoals() async {
    final response = await supabaseClient.from('goals').select();

    return response.map((data) => GoalModel.fromJson(data)).toList();
  }

  @override
  Future<void> insertGoal(GoalModel goal, String operationId) async {
    await supabaseClient.rpc(
      'process_goal_insert',
      params: {
        'p_operation_id': operationId,
        'p_entity_id': goal.id,
        'p_title': goal.title,
        'p_target_amount': goal.targetAmount,
        'p_deadline': goal.deadline.toUtc().toIso8601String(),
        'p_status': goal.status.index,
        'p_contribution_period': goal.contributionPeriod.index,
      },
    );
  }

  @override
  Future<void> updateGoal(GoalModel goal) async {
    await supabaseClient.from('goals').update(goal.toJson()).eq('id', goal.id);
  }
}
