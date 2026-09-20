import 'package:monex/features/expense/data/models/expense_model.dart';
import 'package:monex/features/expense/data/source/remote/expense_remote_data_source.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExpenseRemoteDataSourceImpl implements ExpenseRemoteDataSource {
  final SupabaseClient supabaseClient;

  ExpenseRemoteDataSourceImpl(this.supabaseClient);
  @override
  Future<List<ExpenseModel>> getExpenses() async {
    final response = await supabaseClient.from('expenses').select();
    return response.map((data) => ExpenseModel.fromJson(data)).toList();
  }

  @override
  Future<void> addExpense(ExpenseModel expense) async {
    return supabaseClient.from('expenses').insert(expense.toJson());
  }

  @override
  Future<void> updateExpense(ExpenseModel expense) async {
    return await supabaseClient
        .from('expenses')
        .update(expense.toJson())
        .eq('id', expense.id);
  }

  @override
  Future<ExpenseModel?> getExpenseById(String id) async {
    final response = await supabaseClient
        .from('expenses')
        .select()
        .eq('id', id);
    if (response.isEmpty) return null;
    return ExpenseModel.fromJson(response.first);
  }

  @override
  Future<void> deleteExpense(String expenseId) async {
    return await supabaseClient.from('expenses').delete().eq('id', expenseId);
  }

  @override
  Future<void> processExpenseInsert({
    required String operationId,
    required ExpenseModel expense,
  }) async {
    await supabaseClient.rpc(
      'process_expense_insert',
      params: {
        'p_operation_id': operationId,
        'p_entity_id': expense.id,
        'p_title': expense.title,
        'p_amount': expense.amount,
        'p_category_id': expense.categoryId,
        'p_date': expense.date.toUtc().toIso8601String(),
        'p_method': expense.method,
      },
    );
  }
}
