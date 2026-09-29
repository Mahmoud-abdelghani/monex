import 'package:monex/features/savings/data/models/saving_model.dart';
import 'package:monex/features/savings/data/source/remote/savings_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SavingsRemoteDataSourceImpl implements SavingsRemoteDataSource {
  final SupabaseClient supabaseClient;

  SavingsRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<void> deleteSaving(String savingId) async {
    return await supabaseClient.from('savings').delete().eq('id', savingId);
  }

  @override
  Future<SavingModel?> getSavingById(String savingId) async {
    final response = await supabaseClient
        .from('savings')
        .select()
        .eq('id', savingId)
        .maybeSingle();
    if (response == null) {
      return null;
    }
    return SavingModel.fromJson(response);
  }

  @override
  Future<List<SavingModel>> getSavings() async {
    final response = await supabaseClient.from('savings').select();
    return response.map((data) => SavingModel.fromJson(data)).toList();
  }

  @override
  Future<List<SavingModel>> getSavingsByGoalId(String goalId) async {
    final response = await supabaseClient
        .from('savings')
        .select()
        .eq('goal_id', goalId);
    return response.map((data) => SavingModel.fromJson(data)).toList();
  }

  @override
  Future<void> insertSaving(SavingModel saving, String operationId) async {
    await supabaseClient.rpc(
      'process_saving_insert',
      params: {
        'p_operation_id': operationId,
        'p_entity_id': saving.id,
        'p_goal_id': saving.goalId,
        'p_amount': saving.amount,
        'p_date': saving.date.toUtc().toIso8601String(),
      },
    );
  }

  @override
  Future<void> updateSaving(SavingModel saving) async {
    return await supabaseClient
        .from('savings')
        .update(saving.toJson())
        .eq('id', saving.id);
  }
}
