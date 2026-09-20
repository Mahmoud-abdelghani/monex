import 'package:monex/features/income/data/models/income_model.dart';
import 'package:monex/features/income/data/source/remote/incomes_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IncomesRemoteDataSourceImpl implements IncomesRemoteDataSource {
  final SupabaseClient supabaseClient;
  IncomesRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<void> deleteIncome(String id) async {
    return await supabaseClient.from('incomes').delete().eq('id', id);
  }

  @override
  Future<IncomeModel> getIncomeById(String id) async {
    final response = await supabaseClient.from('incomes').select().eq('id', id);
    return IncomeModel.fromJson(response.first);
  }

  @override
  Future<List<IncomeModel>> getIncomes() async {
    final response = await supabaseClient.from('incomes').select();
    return response.map((data) => IncomeModel.fromJson(data)).toList();
  }

  @override
  Future<void> insertIncome(IncomeModel data) async {
    return await supabaseClient.from('incomes').insert(data.toJson());
  }

  @override
  Future<void> processIncomeInsert({
    required String operationId,
    required IncomeModel income,
  }) {
    return supabaseClient.rpc(
      'process_income_insert',
      params: {
        'p_operation_id': operationId,
        'p_entity_id': income.id,
        'p_title': income.title,
        'p_amount': income.amount,
        'p_category_id': income.categoryId,
        'p_date': income.date.toUtc().toIso8601String(),
        'p_method': income.method,
      },
    );
  }

  @override
  Future<void> updateIncome(IncomeModel data) async {
    return await supabaseClient
        .from('incomes')
        .update(data.toJson())
        .eq('id', data.id);
  }
}
