import 'package:monex/features/budget/data/model/budget_model.dart';
import 'package:monex/features/budget/data/source/remote/budget_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BudgetRemoteDataSourceImpl implements BudgetRemoteDataSource {
  final SupabaseClient supabaseClient;

  BudgetRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<void> createBudget(BudgetModel data) async {
    return await supabaseClient.from('budget').insert(data.toJson());
  }

  @override
  Future<BudgetModel?> getCurrentBudget(String userId) async {
    final response = await supabaseClient
        .from('budget')
        .select()
        .eq('user_id', userId)
        .maybeSingle();
    if (response == null) return null;
    return BudgetModel.fromJson(response);
  }

  @override
  Future<void> updateBudget(BudgetModel data) {
    return supabaseClient
        .from('budget')
        .update(data.toJson())
        .eq('id', data.id);
  }
}
